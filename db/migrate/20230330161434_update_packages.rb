class UpdatePackages < ActiveRecord::Migration[7.0]
  def change
    change_table :packages do |t|
      t.remove :description, :field, :number_sessions, :discount, :booking_id
    end
  end
end
