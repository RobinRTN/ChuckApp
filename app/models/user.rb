class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_token_and_url
  before_destroy :delete_formules


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end

  has_many :clients
  has_many :bookings
  has_many :formules
  has_many :packages
  has_one_attached :profile_picture
  has_many_attached :gallery_pictures

  private

  def set_token_and_url
    self.token = SecureRandom.base64(10)
    self.url = "/reservation/#{self.token}"
  end

  def delete_formules
    self.formules.destroy_all
  end

end
