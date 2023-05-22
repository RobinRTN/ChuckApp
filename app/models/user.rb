class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :onboarding_process
  before_validation :set_token
  before_validation :generate_qr_code
  before_validation :full_address
  before_save :set_full_name
  before_save :extract_billing_city
  before_destroy :delete_formules
  before_destroy :delete_groups

  serialize :days_of_week, Array

  with_options if: :onboarding_process do |user|
    user.validates :first_name, :last_name, :phone_number, :title, :description, :address, presence: true
    user.validates :phone_number, format: { with: /\A(\+33|0)[67]\d{8}\z/, message: "Merci d'enter un numéro de téléphone au bon format" }
  end


  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :groups
  has_many :clients
  has_many :bookings
  has_many :packages
  has_many :availables
  has_many :availability_weeks
  has_many :tags
  has_many :formules, through: :packages
  accepts_nested_attributes_for :packages, allow_destroy: true
  has_one_attached :profile_picture
  has_many_attached :gallery_pictures
  has_one_attached :qrcode

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end


  private

  def onboarding_process?
    onboarding_process == true
  end

  def set_token
    self.token = SecureRandom.urlsafe_base64(10)
  end

  def delete_formules
    self.formules.destroy_all
  end

  def delete_groups
    self.groups.destroy_all
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

  def reservation_link(token)
    if Rails.env.production?
      "https://salty-sierra-39179.herokuapp.com/landing_reservation/#{token}"
    else
      "http://localhost:3000/landing_reservation/#{token}"
    end
  end

  def full_address
    self.address = "#{billing_address_line1}, #{billing_city}" if billing_address_line1.present? && billing_city.present?
  end

  def set_full_name
    self.full_name = "#{first_name} #{last_name}".strip
  end

  def extract_billing_city
    if address.present?
      match_data = address.match(/(\d{5,})\s(?:\p{L}+\s)*?(.+),\sFrance/)
      self.billing_city = match_data[2] if match_data
    end
  end

end
