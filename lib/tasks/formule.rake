namespace :formule do
  desc "Update address_line for all Formules with the associated User's address if missing"
  task update_addresses: :environment do
    Formule.find_each do |formule|
      if formule.address_line.nil? && formule.user.present? && formule.user.address.present?
        formule.update(address_line: formule.user.address)
        puts "Updated address_line for Formule ##{formule.id}"
      end
    end
    puts "Address update task finished."
  end
end
