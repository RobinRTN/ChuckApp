class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :conditions, :politique, :mentions ]

  before_action :check_onboarding_status, except: [:conditions, :politique, :mentions ]

  def check_onboarding_status
    if user_signed_in?
      if current_user && !current_user.step_1
        redirect_to onboarding_path(step: 'step1')
      elsif current_user && !current_user.step_2
        redirect_to onboarding_path(step: 'step2')
      elsif current_user && !current_user.step_3
        redirect_to onboarding_path(step: 'step3')
      elsif current_user && !current_user.step_4
        redirect_to onboarding_path(step: 'step4')
      end
    end
  end

  def home
    if user_signed_in?

      if current_user&.needs_onboarding
        @show_onboarding = true
      end
      @bookings_accepted_upcoming = Booking.upcoming_accepted
      @user_bookings_calendar
      @user_bookings_passed = current_user.bookings.passed_current_month
      @user_bookings_projected = current_user.bookings.current_month_projected
      @user_bookings_rest = current_user.bookings.current_month_rest
      @user_bookings_number = @user_bookings_passed.count
      @user_bookings_number_proj = @user_bookings_projected.count - @user_bookings_passed.count
      @passed_month_revenues = @user_bookings_passed.sum(&:price)
      @projected_month_revenues = @user_bookings_projected.sum(&:price)
      @client_rankings = rank_clients_by_revenue()
      @upcoming_bookings = current_user.bookings.upcoming
      @calendar_bookings = current_user.bookings.where("start_time BETWEEN ? AND ? AND status IN ('Accepted', 'Pending') AND cancel_type != 'Cancelled'", 3.months.ago, 3.months.from_now)
      @user = current_user
    end
  end

  def send_test_push_notification
    PushNotificationService.send(current_user, "Test ChuckApp", "#{Time.zone.now}", "/profile")
    render json: { status: 'ok' }, status: :ok
  end

  def profile
    @user = current_user
    @subscriptions = current_user.subscriptions
    @subscribed = @subscriptions.any? {  |subscription| subscription.device_id == cookies[:DeviceId] }
  end

  def conditions
  end

  def politique
  end

  def mentions
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
