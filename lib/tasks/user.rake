# namespace :user do
#   desc 'Update user tokens and qr codes'
#   task update_tokens: :environment do
#     User.find_each do |user|
#       user.send(:set_full_name)
#       user.send(:set_token)
#       user.send(:generate_qr_code)
#       user.send(:extract_billing_city)
#       user.save
#     end
#   end
# end

namespace :user do
  desc "Update step_1 to step_4 for all users"
  task update_steps: :environment do
    User.find_each do |user|
      if user.full_name.blank?
        user.update(step_1: false, step_2: false, step_3: false, step_4: false)
      else
        user.update(step_1: true, step_2: true, step_3: true, step_4: true)
      end
    end
  end
end
