namespace :user do
  desc 'Update user tokens and qr codes'
  task update_tokens: :environment do
    User.find_each do |user|
      user.send(:set_full_name)
      user.send(:set_token)
      user.send(:generate_qr_code)
      user.send(:extract_billing_city)
      user.save
    end
  end
end

