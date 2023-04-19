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
    mail(to: @client.email, subject: 'Demande de réservation envoyée')
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
end
