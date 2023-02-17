class AddEventToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :event, :string
  end
end
