# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Deleting Users"
User.destroy_all

puts "Deleting Clients"
Client.destroy_all

puts "Deleting Bookings"
Booking.destroy_all

puts "Starting to generate the users and activities..."
puts "_________________"

User.create!([
  { full_name: "Robin Rettien", hourly_rate: 70, email: 'robinrettien@test.com', password: 'password', first_name: "Robin", last_name: "Rettien", payment_BIC: "BFBKFRP1", payment_IBAN: "FR3330002005500000157841Z25", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" },

  { full_name: "Maxime Lavoine", hourly_rate: 90, email: 'maximelavoine@test.com', password: 'password', first_name: "Maxime", last_name: "Lavoine", payment_BIC: "BFBKFKP1", payment_IBAN: "FR3330002105500000157841Z25", billing_address_line1: "15 avenue de Kelber", billing_zip_code: 75011, billing_city: "Paris" }
  ])

puts "Just created the two founders' accounts successfully"
puts "_________________"

Client.create!([
  { user_id: User.first.id, full_name: "Benoit Stephan", email: 'benoitstephan@test.com', payment_BIC: "BFBKFRP1", payment_IBAN: "FR3330002005500000157841Z25", billing_address_line1: "43 rue de l'Eglise", billing_zip_code: 75015, billing_city: "Paris" },

  { user_id: User.first.id, full_name: "Pierre Schumacher", email: 'pierreschumacher@test.com', payment_BIC: "BFBKFRT1", payment_IBAN: "FR3330002025500000157841Z25", billing_address_line1: "43 rue de Kleber", billing_zip_code: 75008, billing_city: "Paris" },

  { user_id: User.first.id, full_name: "Hugo Thibault", email: 'hugothibault@test.com', payment_BIC: "FFBKFRT1", payment_IBAN: "FR3332202025500000157841Z25", billing_address_line1: "43 rue du taudis", billing_zip_code: 75005, billing_city: "Paris" },

  { user_id: User.first.id, full_name: "Hadrien Sertin", email: 'hadriensertin@test.com', payment_BIC: "FFBKFSS1", payment_IBAN: "FR3332202025500000157841895", billing_address_line1: "43 rue du pont", billing_zip_code: 93500, billing_city: "Pantin" },

  { user_id: User.first.id, full_name: "Mélanie Guichard", email: 'melanieguichard@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" },

  { user_id: User.second.id, full_name: "Vanille Fremaux", email: 'vanillefremaux@test.com', payment_BIC: "FFBKPSS3", payment_IBAN: "FR3992202025500000157841866", billing_address_line1: "15 avenue de Kelber", billing_zip_code: 75011, billing_city: "Paris" },

  { user_id: User.second.id, full_name: "Victor Launay", email: 'victorlaunay@test.com', payment_BIC: "FFBKAZS3", payment_IBAN: "FR3992202025500000157842366", billing_address_line1: "15 avenue de la trace", billing_zip_code: 75018, billing_city: "Paris" },

  { user_id: User.second.id, full_name: "Lenny Krief", email: 'lennykrief@test.com', payment_BIC: "PPBKPSS3", payment_IBAN: "FR3992202025500000157832166", billing_address_line1: "17 avenue de Londres", billing_zip_code: 75009, billing_city: "Paris" },

  { user_id: User.second.id, full_name: "Enzo Dubos", email: 'enzodubos@test.com', payment_BIC: "FFIOPSS3", payment_IBAN: "FR3992202025500000157848886", billing_address_line1: "22 avenue de Gauche", billing_zip_code: 75019, billing_city: "Paris" },

  { user_id: User.second.id, full_name: "Will Smith", email: 'willsmith@test.com', payment_BIC: "USBKPSS3", payment_IBAN: "FR3222202025500000157841866", billing_address_line1: "15 avenue de New York", billing_zip_code: 75020, billing_city: "Paris" }
])


puts "Just created the 10 clients successfully"
puts "_________________"

puts "Just created the 6 sports successfully"
puts "_________________"
