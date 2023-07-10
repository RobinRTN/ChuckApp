# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  def user_booking_email_pending
    user = User.first # Replace this with a suitable User object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.user_booking_email_pending(user, booking)
  end

  def client_booking_email_pending
    client = Client.first # Replace this with a suitable Client object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.client_booking_email_pending(client, booking)
  end

  def user_booking_email
    user = User.first # Replace this with a suitable User object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.user_booking_email(user, booking)
  end

  def client_booking_email
    client = Client.first # Replace this with a suitable Client object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.client_booking_email(client, booking)
  end

  def user_booking_email_refuse
    user = User.first # Replace this with a suitable User object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.user_booking_email_refuse(user, booking)
  end

  def client_booking_email_refuse
    client = Client.first # Replace this with a suitable Client object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.client_booking_email_refuse(client, booking)
  end

  def user_booking_email_cancel
    user = User.first # Replace this with a suitable User object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.user_booking_email_cancel(user, booking)
  end

  def client_booking_email_cancel
    client = Client.first # Replace this with a suitable Client object
    booking = Booking.first # Replace this with a suitable Booking object
    BookingMailer.client_booking_email_cancel(client, booking)
  end

  def send_email_announce
    BookingMailer.send_email_announce(Booking.first)
  end

  def send_email_new_user
    BookingMailer.send_email_new_user(User.first)
  end

  def user_booking_email_refuse_client
    BookingMailer.user_booking_email_refuse_client(User.first, Booking.first)
  end

  def client_booking_email_refuse_client
    BookingMailer.client_booking_email_refuse_client(Client.first, Booking.first)
  end

  def user_booking_email_modif_time
    BookingMailer.user_booking_email_modif_time(User.first, Booking.first)
  end

  def client_booking_email_modif_time
    BookingMailer.client_booking_email_modif_time(Client.first, Booking.first)
  end
end
