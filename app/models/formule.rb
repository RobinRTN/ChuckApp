class Formule < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :nullify
  before_validation :set_default_address
  geocoded_by :address_line
  after_validation :geocode, if: :will_save_change_to_address_line?

  validates :name, :price, :duration, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.1 }

  scope :active, -> { where(archived: false) }
  scope :inactive, -> { where(archived: true) }


  private

  def set_default_address
    self.address_line ||= self.user.address
  end

end
