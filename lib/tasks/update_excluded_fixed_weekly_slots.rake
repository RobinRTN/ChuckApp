namespace :user do
  desc "Update excluded_fixed_weekly_slots"
  task update_excluded_fixed_weekly_slots: :environment do
    User.find_each do |user|
      if user.excluded_fixed_weekly_slots.blank? || user.excluded_fixed_weekly_slots == "\"[]\""
        user.update(excluded_fixed_weekly_slots: [])
        puts "Updated User ID: #{user.id}"
      end
    end
  end
end
