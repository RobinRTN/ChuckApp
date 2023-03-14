class Client < ApplicationRecord
  before_validation :set_full_name
  before_validation :split_full_name, if: -> { full_name.present? && (first_name.blank? || last_name.blank?) }

  belongs_to :user
  has_many :group_clients, dependent: :destroy
  has_many :groups, through: :group_clients
  has_many :bookings
  has_one_attached :photo

  private

  def set_full_name
    self.full_name = "#{first_name} #{last_name}" if first_name.present? && last_name.present?
  end

  def split_full_name
    name_parts = full_name.split(' ')
    self.first_name = name_parts.shift
    self.last_name = name_parts.join(' ')
  end

end
