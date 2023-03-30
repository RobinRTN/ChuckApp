class Formule < ApplicationRecord
  belongs_to :user
  belongs_to :package, optional: true
  has_many :bookings
  before_validation :set_default_address
  geocoded_by :address_line
  after_validation :geocode, if: :will_save_change_to_address_line?

  private

  def set_default_address
    self.address_line ||= user.address
  end

end
