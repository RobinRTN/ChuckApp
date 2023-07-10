class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :onboarding_process
  attr_accessor :onboarding_process_step4
  before_validation :full_address
  before_save :set_full_name
  before_save :set_token
  before_save :extract_billing_city
  before_save :check_excluded_fixed_weekly_slots
  before_save :set_default_times
  before_destroy :delete_formules
  before_destroy :delete_groups
  after_initialize :init
  after_create :send_email_new_user


  serialize :days_of_week, Array

  with_options if: :onboarding_process do |user|
    user.validates :first_name, :last_name, :phone_number, :title, :description, :address, presence: true
    user.validates :phone_number, format: { with: /\A(\+33|0)[67]\d{8}\z/, message: "Merci d'enter un numéro de téléphone au bon format" }
  end


  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :groups
  has_many :clients, dependent: :delete_all
  has_many :bookings
  has_many :availables
  has_many :availability_weeks
  has_many :tags
  has_many :formules, dependent: :destroy
  accepts_nested_attributes_for :formules, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  # accepts_nested_attributes_for :packages, allow_destroy: true
  has_one_attached :profile_picture
  has_many_attached :gallery_pictures
  has_one_attached :qrcode


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # Confirm the email only for users registering through Google OAuth
    user.confirmed_at = Time.current
    end
  end

  def send_email_new_user
    BookingMailer.send_email_new_user(self).deliver_now if Rails.env.production?
  end

  def init
    self.step_1 ||= false
    self.step_2 ||= false
    self.step_3 ||= false
    self.step_4 ||= false
  end


  private

  def onboarding_process?
    onboarding_process == true
  end

  def set_token
    if self.token.nil? || full_name_changed?
      self.token = unique_token(full_name)
      # Call generate_qr_code method when a new token is generated
      generate_qr_code
    end
  end

  def set_default_times
    self.daily_start_time = '9:00' if self.daily_start_time.blank?
    self.daily_end_time = '18:00' if self.daily_end_time.blank?
  end


  def generate_qr_code
    qrcode = RQRCode::QRCode.new(reservation_link(self.token))
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 200
    )

    self.qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: "qrcode.png",
      content_type: 'image/png'
    )
  end


  def unique_token(name)
    base_token = name.parameterize
    token = base_token
    i = 1

    while User.exists?(token: token)
      token = "#{base_token}-#{i}"
      i += 1
    end

    token
  end

  def delete_formules
    self.formules.destroy_all
  end

  def delete_groups
    self.groups.destroy_all
  end


  def reservation_link(token)
    if Rails.env.production?
      "http://chuckapp.fr/#{token}"
    else
      "http://localhost:3000/#{token}"
    end
  end

  def full_address
    self.address = "#{billing_address_line1}, #{billing_city}" if billing_address_line1.present? && billing_city.present?
  end

  def set_full_name
    self.full_name = "#{first_name} #{last_name}".strip
  end

  def check_excluded_fixed_weekly_slots
    self.excluded_fixed_weekly_slots = [] if self.excluded_fixed_weekly_slots.blank? || self.excluded_fixed_weekly_slots == "\"[]\""
  end

  def extract_billing_city
    if address.present?
      match_data = address.match(/(\d{5,})\s(?:\p{L}+\s)*?(.+),\sFrance/)
      self.billing_city = match_data[2] if match_data
    end
  end

end
