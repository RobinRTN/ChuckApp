namespace :booking do
  desc "Add cancellation token to existing bookings"
  task add_cancellation_token: :environment do
    Booking.find_each do |booking|
      booking.update(cancellation_token: SecureRandom.hex(10))
    end
  end
end
