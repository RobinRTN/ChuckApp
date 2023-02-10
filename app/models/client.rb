class Client < ApplicationRecord
  belongs_to :user
  has_many :client_bookings
  has_many :bookings, through: :client_bookings
end
