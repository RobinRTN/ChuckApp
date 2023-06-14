class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_pending_booking
  # before_action :set_locale
  before_action :check_onboarding_status

  def check_onboarding_status
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

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def set_pending_booking
    @pending_booking = current_user.bookings.all_pending.first if current_user
  end

  # def set_locale
  #   if request.path.starts_with?('/admin')
  #     raise
  #     I18n.locale = :en
  #   else
  #     I18n.locale = I18n.default_locale
  #   end
  # end
end
