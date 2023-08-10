class Subscription < ApplicationRecord
  belongs_to :user

  validates :endpoint, presence: true
  validates :p256dh_key, presence: true
  validates :auth_key, presence: true
  validates :device_id, presence: true, uniqueness: { scope: :user_id }
end
