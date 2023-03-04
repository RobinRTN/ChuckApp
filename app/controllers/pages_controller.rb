class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
    user_bookings_passed = current_user.bookings.passed_current_month
    user_bookings_projected = current_user.bookings.current_month_projected
    @user_bookings_number = user_bookings_passed.count
    @user_bookings_number_proj = user_bookings_projected.count - user_bookings_passed.count
    @passed_month_revenues = user_bookings_passed.sum(&:price)
    @projected_month_revenues = user_bookings_projected.sum(&:price)
    @client_rankings = rank_clients_by_revenue()
    @upcoming_bookings = current_user.bookings.upcoming

    @calendar_bookings = Booking.where(start_time: Date.today.beginning_of_month..Date.today.end_of_month)
    @calendar_bookings_by_day = @calendar_bookings.group_by { |booking| booking.start_time.day }
    end
  end

  def profile
  end

  private

  def rank_clients_by_revenue
    current_month_bookings = current_user.bookings.passed_current_month.includes(:client)
    user_revenues = Hash.new(0)
    current_month_bookings.each do |booking|
      user_revenues[booking.client] += booking.price
    end
    sorted_user_revenues = user_revenues.sort_by { |user, revenue| revenue }.reverse
  end

end
