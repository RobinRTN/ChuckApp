class AddBreakTimeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :break_time, :integer, default: 0
  end
end
