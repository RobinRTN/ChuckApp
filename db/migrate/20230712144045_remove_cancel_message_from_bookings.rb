class RemoveCancelMessageFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :cancel_message, :string
  end
end
