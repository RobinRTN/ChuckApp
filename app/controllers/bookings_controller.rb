class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def index
    user_bookings = current_user.bookings
    @today_bookings = user_bookings.today
    @tomorrow_bookings = user_bookings.tomorrow
    @this_week_bookings = user_bookings.this_week
    @next_week_bookings = user_bookings.next_week
    @next_month_bookings = user_bookings.next_month
    @after_bookings = user_bookings.after
    @passed_bookings = user_bookings.passed

    @today_pending_bookings = user_bookings.today_pending
    @tomorrow_pending_bookings = user_bookings.tomorrow_pending
    @this_week_pending_bookings = user_bookings.this_week_pending
    @next_week_pending_bookings = user_bookings.next_week_pending
    @next_month_pending_bookings = user_bookings.next_month_pending
    @after_pending_bookings = user_bookings.after_pending
  end

  def confirm
    @booking = Booking.find(params[:id])
    @booking.update(status: "Accepted")
    redirect_to bookings_path
  end

  def refuse
    @booking = Booking.find(params[:id])
    @booking.update(status: "Refused")
    redirect_to bookings_path
  end

end
