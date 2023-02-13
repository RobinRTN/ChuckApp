class AddStatusToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :status, :string, default: "Pending"
  end
end
