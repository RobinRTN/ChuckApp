class ChangeOnboardingFieldsInUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :daily_start_time, :string
    add_column :users, :daily_end_time, :string
    add_column :users, :excluded_fixed_weekly_slots, :jsonb, default: []
  end
end
