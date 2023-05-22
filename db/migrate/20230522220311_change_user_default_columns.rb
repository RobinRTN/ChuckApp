class ChangeUserDefaultColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :daily_start_time, "9:00"
    change_column_default :users, :daily_end_time, "18:00"
    change_column_default :users, :billing_city, "Paris"
  end
end
