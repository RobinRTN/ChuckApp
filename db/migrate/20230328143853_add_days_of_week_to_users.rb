class AddDaysOfWeekToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :days_of_week, :text, default: '--- ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]'
  end
end
