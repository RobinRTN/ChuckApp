class OnboardingController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    # Render the view for the current onboarding step
    render step
  end

  def update
    @user = current_user
    # Update user attributes and go to the next step
    if @user.update(user_params)
      redirect_to onboarding_path(step: next_step)
    else
      render step
    end
  end

  private

  def step
    # Determine the current step from the URL params, default to 'step1'
    @step ||= params[:step] || 'step1'
  end

  def next_step
    # Define the order of your onboarding steps
    case step
    when 'step1' then 'step2'
    when 'step2' then 'step3'
    when 'step3' then 'step4'
    # Add more steps as needed
    else
      # If there's no next step, redirect to the user's dashboard or a similar page
      root_path
    end
  end

  def user_params
    params.require(:user).permit(:daily_start_time, :daily_end_time, :excluded_fixed_weekly_slots)
  end
end
