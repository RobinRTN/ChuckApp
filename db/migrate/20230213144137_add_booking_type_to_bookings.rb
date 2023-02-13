class AddBookingTypeToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booking_type, :string, default: "Individuel"
  end
end
