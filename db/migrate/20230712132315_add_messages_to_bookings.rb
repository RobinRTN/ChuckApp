class AddMessagesToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :refusal_message, :text
    add_column :bookings, :cancel_message, :text
  end
end
