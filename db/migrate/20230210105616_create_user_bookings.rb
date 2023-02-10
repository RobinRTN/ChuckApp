class CreateUserBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true
      t.timestamps
    end
  end
end
