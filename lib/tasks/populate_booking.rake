namespace :db do
  desc "Populate the database with sample data for user 127"
  task populate: :environment do
    user = User.find(127)
    formules = user.formules.limit(3)
    clients = user.clients.limit(5)

    # bookings for next month
    15.times do
      start_time = (DateTime.now.next_month.beginning_of_month..DateTime.now.next_month.end_of_month).to_a.sample + rand(9..17).hours
      create_booking(start_time, formules, clients, user)
    end

    # bookings for current month
    15.times do
      start_time = (DateTime.now.beginning_of_month..DateTime.now.end_of_month).to_a.sample + rand(9..17).hours
      create_booking(start_time, formules, clients, user)
    end
  end

  def create_booking(start_time, formules, clients, user)
    end_time = start_time + 2.hours
    price = [80, 100].sample
    payment_status = ['Réglé', 'Non réglé'].sample
    formule_id = formules.sample.id
    booking_type = ['Collectif', 'Individuel'].sample
    status = ['Accepted', 'Pending'].sample

    booking = Booking.new(
      start_time: start_time,
      end_time: end_time,
      price: price,
      payment_status: payment_status,
      booking_type: booking_type,
      status: status,
      formule_id: formule_id,
      client_id: clients.sample.id,
      user_id: user.id,
      message: Faker::Lorem.sentence(word_count: 25)
    )
    booking.save
  end
end
