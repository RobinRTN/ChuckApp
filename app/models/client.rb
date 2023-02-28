class Client < ApplicationRecord
  before_validation :set_full_name

  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  private

  def set_full_name
    self.full_name = "#{first_name} #{last_name}" if first_name.present? && last_name.present?
  end

end
