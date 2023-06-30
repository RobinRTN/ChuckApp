class AddNeedsOnboardingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :needs_onboarding, :boolean, default: true
  end
end
