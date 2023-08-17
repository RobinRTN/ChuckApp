class BookingMailerJob
  include Sidekiq::Worker

  def perform(method_name, user_id, booking_id)
    user = User.find(user_id)
    booking = Booking.find(booking_id)
    client = Client.find(booking.client_id)

    case method_name
    when "user_booking_email"
      BookingMailer.user_booking_email(user, booking).deliver_now
    when "client_booking_email"
      BookingMailer.client_booking_email(client, booking).deliver_now
    when "user_booking_email_refuse"
      BookingMailer.user_booking_email_refuse(user, booking).deliver_now
    when "client_booking_email_refuse"
      BookingMailer.client_booking_email_refuse(client, booking).deliver_now
    when "user_booking_email_refuse_client"
      BookingMailer.user_booking_email_refuse_client(user, booking).deliver_now
    when "client_booking_email_refuse_client"
      BookingMailer.client_booking_email_refuse_client(client, booking).deliver_now
    when "user_booking_email_modif_time"
      BookingMailer.user_booking_email_modif_time(user, booking).deliver_now
    when "client_booking_email_modif_time"
      BookingMailer.client_booking_email_modif_time(client, booking).deliver_now
    when "user_booking_email_modif_time_confirm"
      BookingMailer.user_booking_email_modif_time_confirm(user, booking).deliver_now
    when "client_booking_email_modif_time_confirm"
      BookingMailer.client_booking_email_modif_time_confirm(client, booking).deliver_now
    end
  end
end
