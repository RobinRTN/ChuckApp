# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
require 'open-uri'
require 'active_support/time'
Time.zone = 'Europe/Paris'

#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Deleting Bookings"
Booking.destroy_all

puts "Deleting Clients"
Client.destroy_all


puts "Deleting Users"
User.destroy_all


puts "Starting to generate the users and activities..."
puts "_________________"

u1 = User.create!({ full_name: "Robin Rettien", hourly_rate: 70, email: 'robinrettien@test.com', password: 'password', first_name: "Robin", last_name: "Rettien", payment_BIC: "BFBKFRP1", payment_IBAN: "FR3330002005500000157841Z25", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

u2 = User.create!({ full_name: "Maxime Lavoine", hourly_rate: 90, email: 'maximelavoine@test.com', password: 'password', first_name: "Maxime", last_name: "Lavoine", payment_BIC: "BFBKFKP1", payment_IBAN: "FR3330002105500000157841Z25", billing_address_line1: "15 avenue de Kelber", billing_zip_code: 75011, billing_city: "Paris" })

puts "Just created the two founders' accounts successfully"
puts "_________________"

u1.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/robin_xlupho.jpg'),
  filename: 'robin.jpg',
  content_type: 'image/jpg'
)
u1.save!

u2.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Maxime_v3rukm.jpg'),
  filename: 'maxime.jpg',
  content_type: 'image/jpg'
)
u2.save!

puts "Just created the two founders' pictures successfully"
puts "_________________"

c1 = Client.create!({ user_id: User.first.id, full_name: "Corentin Bénard", email: 'corentinbenard@test.com', payment_BIC: "BFBKFRP1", payment_IBAN: "FR3330002005500000157841Z25", billing_address_line1: "43 rue de l'Eglise", billing_zip_code: 75015, billing_city: "Paris" })

c2 = Client.create!( { user_id: User.first.id, full_name: "Pierre Schumacher", email: 'pierreschumacher@test.com', payment_BIC: "BFBKFRT1", payment_IBAN: "FR3330002025500000157841Z25", billing_address_line1: "43 rue de Kleber", billing_zip_code: 75008, billing_city: "Paris" })

c3 = Client.create!( { user_id: User.first.id, full_name: "Hugo Thibault", email: 'hugothibault@test.com', payment_BIC: "FFBKFRT1", payment_IBAN: "FR3332202025500000157841Z25", billing_address_line1: "43 rue du taudis", billing_zip_code: 75005, billing_city: "Paris" })

c4 = Client.create!( { user_id: User.first.id, full_name: "Hadrien Sertin", email: 'hadriensertin@test.com', payment_BIC: "FFBKFSS1", payment_IBAN: "FR3332202025500000157841895", billing_address_line1: "43 rue du pont", billing_zip_code: 93500, billing_city: "Pantin" })

c5 = Client.create!( { user_id: User.first.id, full_name: "Mélanie Guichard", email: 'melanieguichard@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c6 = Client.create!( { user_id: User.first.id, full_name: "Malo Bedel", email: 'malobedel@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c7 = Client.create!( { user_id: User.first.id, full_name: "Vincent Rocchietta", email: 'vincentrocchiette@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c8 = Client.create!( { user_id: User.first.id, full_name: "Gautier Roselli", email: 'gautierroselli@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c9 = Client.create!( { user_id: User.first.id, full_name: "Dominique Girard", email: 'dominiquegirard@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c10 = Client.create!( { user_id: User.first.id, full_name: "Vanille Fremaux", email: 'vanillefremaux@test.com', payment_BIC: "FFBKPSS3", payment_IBAN: "FR3992202025500000157841866", billing_address_line1: "15 avenue de Kelber", billing_zip_code: 75011, billing_city: "Paris" })

c11 = Client.create!( { user_id: User.first.id, full_name: "Victor Launay", email: 'victorlaunay@test.com', payment_BIC: "FFBKAZS3", payment_IBAN: "FR3992202025500000157842366", billing_address_line1: "15 avenue de la trace", billing_zip_code: 75018, billing_city: "Paris" })

c12 = Client.create!( { user_id: User.first.id, full_name: "Lenny Krief", email: 'lennykrief@test.com', payment_BIC: "PPBKPSS3", payment_IBAN: "FR3992202025500000157832166", billing_address_line1: "17 avenue de Londres", billing_zip_code: 75009, billing_city: "Paris" })

c13 = Client.create!( { user_id: User.first.id, full_name: "Enzo Dubos", email: 'enzodubos@test.com', payment_BIC: "FFIOPSS3", payment_IBAN: "FR3992202025500000157848886", billing_address_line1: "22 avenue de Gauche", billing_zip_code: 75019, billing_city: "Paris" })

c14 = Client.create!( { user_id: User.first.id, full_name: "Will Smith", email: 'willsmith@test.com', payment_BIC: "USBKPSS3", payment_IBAN: "FR3222202025500000157841866", billing_address_line1: "15 avenue de New York", billing_zip_code: 75020, billing_city: "Paris" })

puts "Just created the 10 clients successfully"
puts "_________________"

c1.photo.attach(
  io: URI.open("https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Corentin_bneyvf.jpg"),
  filename: 'Corentin_bneyvf.jpg',
  content_type: 'image/jpg'
)
c1.save!

c2.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Pierre_mkavne.jpg'),
  filename: 'Pierre_mkavne.jpg',
  content_type: 'image/jpg'
)
c2.save!

c3.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Hugo_exm7zw.jpg'),
  filename: 'Hugo_exm7zw.jpg',
  content_type: 'image/jpg'
)
c3.save!

c5.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Me%CC%81lanie_z4nj0h.jpg'),
  filename: 'Me%CC%81lanie_z4nj0h.jpg',
  content_type: 'image/jpg'
)
c5.save!

c6.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Malo_ojsvi7.jpg'),
  filename: 'Malo_ojsvi7.jpg',
  content_type: 'image/jpg'
)
c6.save!

c10.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Vanille_pwhhwr.jpg'),
  filename: 'Vanille_pwhhwr.jpg',
  content_type: 'image/jpg'
)
c10.save!

c11.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Victor_bv5mbm.jpg'),
  filename: 'Victor_bv5mbm.jpg',
  content_type: 'image/jpg'
)
c11.save!

c12.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Lenny_waly5a.jpg'),
  filename: 'Lenny_waly5a.jpg',
  content_type: 'image/jpg'
)
c12.save!

c13.photo.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/enzo_awwezf.jpg'),
  filename: 'enzo_awwezf.jpg',
  content_type: 'image/jpg'
)
c13.save!

booking = Booking.new(start_time: Time.zone.parse("2023-02-13 10:00:00"), end_time: Time.zone.parse("2023-02-13 12:00:00"), price: 100.00, payment_status: 'Réglé', booking_type: 'Collectif')
booking.user_id = User.first.id
booking.client_id = Client.first.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-14 16:00:00"), end_time: Time.zone.parse("2023-02-14 18:00:00"), price: 80.00, payment_status: 'Non réglé', booking_type: 'Individuel', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.first.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-15 8:00:00"), end_time: Time.zone.parse("2023-02-15 10:00:00"), price: 80.00, payment_status: 'Réglé', booking_type: 'Individuel', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.first.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-16 20:00:00"), end_time: Time.zone.parse("2023-02-16 21:00:00"), price: 80.00, payment_status: 'Non réglé', booking_type: 'Individuel', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.first.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-17 10:00:00"), end_time: Time.zone.parse("2023-02-16 12:00:00"), price: 100.00, payment_status: 'Réglé', booking_type: 'Collectif', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.first.id
booking.save


puts "Just created 5 bookings for first client successfully"
puts "_________________"

booking = Booking.new(start_time: Time.zone.parse("2023-02-13 8:00:00"), end_time: Time.zone.parse("2023-02-13 10:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.second.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-14 14:00:00"), end_time: Time.zone.parse("2023-02-14 16:00:00"), price: 100.00, payment_status: 'Réglé')
booking.user_id = User.first.id
booking.client_id = Client.second.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-15 18:00:00"), end_time: Time.zone.parse("2023-02-15 20:00:00"), price: 100.00, payment_status: 'Réglé')
booking.user_id = User.first.id
booking.client_id = Client.second.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-11 12:00:00"), end_time: Time.zone.parse("2023-02-11 14:00:00"), price: 100.00, payment_status: 'Réglé')
booking.user_id = User.first.id
booking.client_id = Client.second.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-11 8:00:00"), end_time: Time.zone.parse("2023-02-11 10:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.second.id
booking.save

puts "Just created 5 bookings for second client successfully"
puts "_________________"

booking = Booking.new(start_time: Time.zone.parse("2023-02-13 18:00:00"), end_time: Time.zone.parse("2023-02-13 20:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.third.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-14 12:00:00"), end_time: Time.zone.parse("2023-02-14 14:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.third.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-15 16:00:00"), end_time: Time.zone.parse("2023-02-15 18:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.third.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-16 10:00:00"), end_time: Time.zone.parse("2023-02-16 12:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.third.id
booking.save
booking = Booking.new(start_time: Time.zone.parse("2023-02-17 18:00:00"), end_time: Time.zone.parse("2023-02-16 20:00:00"), price: 100.00, payment_status: 'Réglé', status: "Accepted")
booking.user_id = User.first.id
booking.client_id = Client.third.id
booking.save

puts "Just created 5 bookings for third client successfully"
puts "_________________"
