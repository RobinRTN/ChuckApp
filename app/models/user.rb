class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(:email => data["email"]).first

  #   unless user
  #     user = User.create!(
  #           email: data["email"],
  #           full_name: data["name"],
  #           avatar_url: data["image"],
  #           # access_token: data["token"],
  #           # expires_at: data["expires_at"],
  #           # refresh_token: data["refresh_token"],
  #           encrypted_password: Devise.friendly_token[0,20]
  #     )
  #   end
  #   user
  # end


  has_many :clients
  has_many :bookings
  has_many :formules
  has_many :packages
  has_one_attached :photo

end
