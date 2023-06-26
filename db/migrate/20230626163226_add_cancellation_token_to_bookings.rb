class AddCancellationTokenToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :cancellation_token, :string
  end
end
