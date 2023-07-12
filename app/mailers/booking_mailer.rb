class BookingMailer < ApplicationMailer
  def user_booking_email_pending(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Demande de réservation reçue')
  end

  def client_booking_email_pending(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    @url = confirm_cancel_booking_url(cancellation_token: @booking.cancellation_token)
    mail(to: @client.email, subject: 'Demande de réservation envoyée')
  end

  def user_booking_email_modif_time_confirm(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Proposition de créneau envoyée')
  end

  def client_booking_email_modif_time_confirm(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    @url_confirm = confirm_suggestion_url(cancellation_token: @booking.cancellation_token)
    mail(to: @client.email, subject: 'Proposition de créneau reçue')
  end

  def user_booking_email(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Nouvelle réservation confirmée')
  end

  def client_booking_email(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    @url = confirm_cancel_booking_url(cancellation_token: @booking.cancellation_token)
    mail(to: @client.email, subject: 'Nouvelle réservation confirmée')
  end

  def user_booking_email_refuse(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Réservation refusée')
  end

  def client_booking_email_refuse(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    mail(to: @client.email, subject: 'Réservation refusée')
  end

  def user_booking_email_refuse_client(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Réservation annulée')
  end

  def client_booking_email_refuse_client(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    mail(to: @client.email, subject: 'Réservation annulée')
  end

  def user_booking_email_cancel(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Réservation annulée')
  end

  def client_booking_email_cancel(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    mail(to: @client.email, subject: 'Réservation annulée')
  end

  def user_booking_email_modif_time(user, booking)
    @user = user
    @booking = booking
    @client = booking.client
    mail(to: @user.email, subject: 'Réservation modifiée')
  end

  def client_booking_email_modif_time(client, booking)
    @client = client
    @booking = booking
    @user = booking.user
    mail(to: @client.email, subject: 'Réservation modifiée')
  end

  def send_email_announce(booking)
    @booking = booking
    @user = booking.user
    @client = booking.client
    mail(to: ['lavoinemaxime@gmail.com', 'robinrettien@gmail.com'], subject: 'Nouvelle réservation effectuée en prod !')
  end

  def send_email_new_user(user)
    @user = user
    mail(to: ['lavoinemaxime@gmail.com', 'robinrettien@gmail.com'], subject: 'Nouvel utilisateur en prod !')
  end
end
