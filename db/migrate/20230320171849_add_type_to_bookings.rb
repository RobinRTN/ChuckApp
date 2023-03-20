class AddTypeToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :cancel_type, :string, default: "Client"
  end
end
