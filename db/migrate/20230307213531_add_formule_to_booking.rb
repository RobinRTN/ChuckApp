class AddFormuleToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :formule, foreign_key: true, default: 13
    change_column_default :bookings, :formule_id, nil
  end
end
