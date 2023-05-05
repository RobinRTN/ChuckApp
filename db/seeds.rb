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

puts "Deleting Formules"
Formule.destroy_all

puts "Deleting Packages"
Package.destroy_all

puts "Deleting Groups"
Group.destroy_all

puts "Deleting Availibles"
Available.destroy_all

puts "Deleting Tags"
Tag.destroy_all

puts "Deleting Week Availibles"
AvailabilityWeek.destroy_all

puts "Deleting Users"
User.destroy_all


puts "Starting to generate the users and activities..."
puts "_________________"

u1 = User.create!({ full_name: "Thomas Courtois", title: "Professeur de Tennis", hourly_rate: 70, email: 'robinrettien@test.com', password: 'password', first_name: "Thomas", last_name: "Courtois", payment_BIC: "BFBKFRP1", payment_IBAN: "FR3330002005500000157841Z25", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

u2 = User.create!({ full_name: "Maxime Lavoine", title: "Professeur de Yoga Indien", hourly_rate: 90, email: 'maximelavoine@test.com', password: 'password', first_name: "Maxime", last_name: "Lavoine", payment_BIC: "BFBKFKP1", payment_IBAN: "FR3330002105500000157841Z25", billing_address_line1: "15 avenue de Kelber", billing_zip_code: 75011, billing_city: "Paris" })

puts "Just created the two founders' accounts successfully"
puts "_________________"

u1.profile_picture.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1683284933/Screenshot_2023-05-05_at_13.08.46_fsikhe.png'),
  filename: 'thomas.png',
  content_type: 'image/png'
)
u1.save!

u1.description = "Je suis un professeur de tennis avec plus de 10 ans d'expérience dans l'enseignement du tennis. J'ai aidé des étudiants à découvrir les joies et les bienfaits de ce sport passionnant. Je suis déterminé à aider mes étudiants à développer leur plein potentiel tout en cultivant le plaisir du jeu."
u1.save!

u1.gallery_pictures.attach(
  [
    { io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1683285018/pexels-anna-shvets-5067824_gvnyfu.jpg'), filename: 'gallery_picture1.jpg', content_type: 'image/jpeg' },
    { io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1683285017/pexels-florian-doppler-3207473_lnkoh5.jpg'), filename: 'gallery_picture2.jpg', content_type: 'image/jpeg' },
    { io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1683285003/pexels-lebih-dari-ini-5908430_vjgypa.jpg'), filename: 'gallery_picture3.jpg', content_type: 'image/jpeg' }
  ]
)
u1.save!

u2.profile_picture.attach(
  io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Maxime_v3rukm.jpg'),
  filename: 'maxime.jpg',
  content_type: 'image/jpg'
)
u2.save!
puts "Just created the two founders' pictures successfully"
puts "_________________"

p1 = Package.create!({ user_id: User.first.id, name: "Tennis" })
p2 = Package.create!({ user_id: User.first.id, name: "Fitness" })

f1 = Formule.create!({ user_id: User.first.id, package_id: p1.id, name: "Tennis découverte", field: 'Tennis', duration: 60, price: 80, description: "Pour les jeunes et moins jeune, ressentez les premières sensations du tennis et des joie de frapper la petite balle jaune" })
f2 = Formule.create!({ user_id: User.first.id, package_id: p1.id, name: "Tennis perfectionnement", field: 'Tennis', duration: 120, price: 150, description: "Tu maitrises les bases du tennis ? Viens perfectionner ta technique pour être plus tranchant sur chaque point" })
f3 = Formule.create!({ user_id: User.first.id, package_id: p1.id, name: "Tennis expert", field: 'Tennis', duration: 60, price: 100, description: "Réservé aux joueurs expérimentés et en forme. On travaille les petits détails pour passer le prochain pallier !" })
puts "Just created the 3 formula successfully"
puts "_________________"

f4 = Formule.create!({ user_id: User.first.id, package_id: p2.id, name: "Stretching Américain", field: 'Fitness', duration: 60, price: 80, description: "Très célèbre stretching de la côte californienne, idéal pour les ischios" })
f5 = Formule.create!({ user_id: User.first.id, package_id: p2.id, name: "Préparation physique G 1", field: 'Fitness', duration: 60, price: 100, description: "Niveau 1, améliore tes capacités physiques et ta VMA" })
f6 = Formule.create!({ user_id: User.first.id, package_id: p2.id, name: "Préparation physique G 2", field: 'Fitness', duration: 60, price: 100, description: "Niveau 2, améliore tes capacités physiques et ta VMA" })
puts "Just created the 3 formula successfully"
puts "_________________"

tags = [
  "remise en forme",
  "tennis",
  "service",
  "perfectionnement",
  "fitness",
  "souplesse",
  "gainage"
]

tags.each do |tag_name|
  u1.tags.create!(name: tag_name)
end

puts "Just created tags successfully"
puts "_________________"

c1 = Client.create!({ user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Corentin Bénard", email: 'corentinbenard@test.com', payment_BIC: "BFBKFRP1", payment_IBAN: "FR3330002005500000157841Z25", billing_address_line1: "43 rue de l'Eglise", billing_zip_code: 75015, billing_city: "Paris" })

c2 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Pierre Schumacher", email: 'pierreschumacher@test.com', payment_BIC: "BFBKFRT1", payment_IBAN: "FR3330002025500000157841Z25", billing_address_line1: "43 rue de Kleber", billing_zip_code: 75008, billing_city: "Paris" })

c3 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", full_name: "Hugo Thibault", email: 'hugothibault@test.com', payment_BIC: "FFBKFRT1", payment_IBAN: "FR3332202025500000157841Z25", billing_address_line1: "43 rue du taudis", billing_zip_code: 75005, billing_city: "Paris" })

c4 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", full_name: "Hadrien Sertin", email: 'hadriensertin@test.com', payment_BIC: "FFBKFSS1", payment_IBAN: "FR3332202025500000157841895", billing_address_line1: "43 rue du pont", billing_zip_code: 93500, billing_city: "Pantin" })

c5 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", full_name: "Mélanie Guichard", email: 'melanieguichard@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c6 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Malo Bedel", email: 'malobedel@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c7 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Vincent Rocchietta", email: 'vincentrocchiette@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c8 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Gautier Roselli", email: 'gautierroselli@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c9 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Dominique Girard", email: 'dominiquegirard@test.com', payment_BIC: "FFBKPSS1", payment_IBAN: "FR3992202025500000157841895", billing_address_line1: "43 avenue de Saxe", billing_zip_code: 75007, billing_city: "Paris" })

c10 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Vanille Fremaux", email: 'vanillefremaux@test.com', payment_BIC: "FFBKPSS3", payment_IBAN: "FR3992202025500000157841866", billing_address_line1: "15 avenue de Kelber", billing_zip_code: 75011, billing_city: "Paris" })

c11 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Victor Launay", email: 'victorlaunay@test.com', payment_BIC: "FFBKAZS3", payment_IBAN: "FR3992202025500000157842366", billing_address_line1: "15 avenue de la trace", billing_zip_code: 75018, billing_city: "Paris" })

c12 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Lenny Krief", email: 'lennykrief@test.com', payment_BIC: "PPBKPSS3", payment_IBAN: "FR3992202025500000157832166", billing_address_line1: "17 avenue de Londres", billing_zip_code: 75009, billing_city: "Paris" })

c13 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Enzo Dubos", email: 'enzodubos@test.com', payment_BIC: "FFIOPSS3", payment_IBAN: "FR3992202025500000157848886", billing_address_line1: "22 avenue de Gauche", billing_zip_code: 75019, billing_city: "Paris" })

c14 = Client.create!( { user_id: User.first.id, phone_number: "0633278600", note:"Très cool!", full_name: "Will Smith", email: 'willsmith@test.com', payment_BIC: "USBKPSS3", payment_IBAN: "FR3222202025500000157841866", billing_address_line1: "15 avenue de New York", billing_zip_code: 75020, billing_city: "Paris" })

puts "Just created the 10 clients successfully"
puts "_________________"

# c1.photo.attach(
#   io: URI.open("https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Corentin_bneyvf.jpg"),
#   filename: 'Corentin_bneyvf.jpg',
#   content_type: 'image/jpg'
# )
# c1.save!

# c2.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Pierre_mkavne.jpg'),
#   filename: 'Pierre_mkavne.jpg',
#   content_type: 'image/jpg'
# )
# c2.save!

# c3.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Hugo_exm7zw.jpg'),
#   filename: 'Hugo_exm7zw.jpg',
#   content_type: 'image/jpg'
# )
# c3.save!

# c5.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Me%CC%81lanie_z4nj0h.jpg'),
#   filename: 'Me%CC%81lanie_z4nj0h.jpg',
#   content_type: 'image/jpg'
# )
# c5.save!

# c6.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Malo_ojsvi7.jpg'),
#   filename: 'Malo_ojsvi7.jpg',
#   content_type: 'image/jpg'
# )
# c6.save!

# c10.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Vanille_pwhhwr.jpg'),
#   filename: 'Vanille_pwhhwr.jpg',
#   content_type: 'image/jpg'
# )
# c10.save!

# c11.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381101/Victor_bv5mbm.jpg'),
#   filename: 'Victor_bv5mbm.jpg',
#   content_type: 'image/jpg'
# )
# c11.save!

# c12.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/Lenny_waly5a.jpg'),
#   filename: 'Lenny_waly5a.jpg',
#   content_type: 'image/jpg'
# )
# c12.save!

# c13.photo.attach(
#   io: URI.open('https://res.cloudinary.com/dk8a13iyc/image/upload/v1676381100/enzo_awwezf.jpg'),
#   filename: 'enzo_awwezf.jpg',
#   content_type: 'image/jpg'
# )
# c13.save!

puts "Just uploaded the pictures for clients successfully"
puts "_________________"

g1 = Group.create!(name: 'Tennis débutants', user_id: User.first.id)
g2 = Group.create!(name: 'Super clients', user_id: User.first.id)
g3 = Group.create!(name: 'Tennis experts', user_id: User.first.id)

# Add clients to groups
g1.clients << [c1, c2, c3, c4, c5]
g2.clients << [c6, c7, c8, c9]
g3.clients << [c10, c11, c12, c13]

puts "Just created 3 groups with clients successfully"
puts "_________________"
# set the current month as a range of dates
current_month_range = Date.current.all_month

# create bookings for the first client
5.times do |i|
  start_time = current_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = 100 # set the price to 100
  payment_status = 'Réglé' # set the payment status to 'Réglé'
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c1.id
  booking.save
end

puts "Just created 5 bookings for first client successfully"
puts c1.id
puts c1.first_name
puts "_________________"

# create bookings for the second client
5.times do |i|
  start_time = current_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = 100 # set the price to 100
  payment_status = 'Réglé' # set the payment status to 'Réglé'
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c2.id
  booking.save
end

puts "Just created 5 bookings for second client successfully"
puts c2.id
puts c2.first_name
puts "_________________"

# create bookings for the third client
5.times do |i|
  start_time = current_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = 100 # set the price to 100
  payment_status = 'Réglé' # set the payment status to 'Réglé'
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c3.id
  booking.save
end

puts "Just created 5 bookings for third client successfully"
puts "_________________"

next_month_range = (Date.current + 1.month).all_month

# create bookings for the fifth client
5.times do |i|
  start_time = current_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c4.id
  booking.save
end

puts "Just created 5 bookings for fifth client successfully"
puts "_________________"

# create bookings for the sixth client
5.times do |i|
  start_time = next_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c5.id
  booking.save
end

5.times do |i|
  start_time = next_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c6.id
  booking.save
end

5.times do |i|
  start_time = next_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c7.id
  booking.save
end

5.times do |i|
  start_time = next_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c8.id
  booking.save
end

5.times do |i|
  start_time = current_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c9.id
  booking.save
end

5.times do |i|
  start_time = current_month_range.to_a.sample + rand(9..17).hours # choose a random day and time between 9am and 5pm
  end_time = start_time + 2.hours # set the end time to be 2 hours after the start time
  price = [80, 100].sample # choose a random price from the array [80, 100]
  payment_status = ['Réglé', 'Non réglé'].sample # choose a random payment status
  formule_id = [f1.id, f2.id, f3.id].sample # choose a random formule_id
  booking_type = ['Collectif', 'Individuel'].sample # choose a random booking type
  status = ['Accepted', 'Pending'].sample # choose a random status or 'Pending'
  booking = Booking.new(start_time: start_time, end_time: end_time, price: price, payment_status: payment_status, booking_type: booking_type, status: status)
  booking.user_id = User.first.id
  booking.message = Faker::Lorem.sentence(word_count: 25) # generate a random booking message
  booking.formule_id = formule_id
  booking.client_id = c12.id
  booking.save
end

puts "Just created 5 bookings for sixth client successfully"
puts "_________________"

puts "===========DONE FOR FIRST USER============="


# start_time = next_month_range.to_a.sample + rand(9..17).hours
# formule_id = [f1.id, f2.id, f3.id].sample
# formule = Formule.find(formule_id)
# end_time = start_time + formule.duration.hours
# price = 100
