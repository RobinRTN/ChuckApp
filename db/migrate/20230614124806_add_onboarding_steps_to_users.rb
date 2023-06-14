class AddOnboardingStepsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :step_1, :boolean
    add_column :users, :step_2, :boolean
    add_column :users, :step_3, :boolean
    add_column :users, :step_4, :boolean
  end
end
