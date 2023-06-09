namespace :db do
  desc "Link formules directly to users"
  task link_formules_to_users: :environment do
    # First, ensure all formules have their user_id field populated from their associated packages
    Formule.where(user_id: nil).find_each do |formule|
      if formule.package
        formule.user_id = formule.package.user_id
        formule.save!
      else
        puts "Formule #{formule.id} has no associated package, skipping"
      end
    end
    # Next, drop the package_id column from the formules table
    ActiveRecord::Base.connection.execute("ALTER TABLE formules DROP COLUMN package_id;")
    # Finally, drop the packages table
    ActiveRecord::Base.connection.execute("DROP TABLE packages;")
    puts "Successfully completed the task!"
  end
end
