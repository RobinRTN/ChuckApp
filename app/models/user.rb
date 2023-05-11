class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_token
  before_validation :generate_qr_code
  before_validation :full_address
  before_destroy :delete_formules
  before_destroy :delete_groups

  serialize :days_of_week, Array





  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end

  has_many :groups
  has_many :clients
  has_many :bookings
  has_many :formules
  has_many :packages
  has_many :availables
  has_many :availability_weeks
  has_many :tags
  has_one_attached :profile_picture
  has_many_attached :gallery_pictures
  has_one_attached :qrcode

  private

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
end
