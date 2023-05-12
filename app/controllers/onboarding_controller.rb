class OnboardingController < ApplicationController
  before_action :authenticate_user!
  helper_method :step, :previous_step


  def show
    @user = current_user
    # Render the view for the current onboarding step
    render step
  end

  def update
    @user = current_user
    case step
    when 'step1'
      if @user.update(step1_params)
        redirect_to onboarding_path(step: next_step)
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :show
      end
    when 'step2'
      if @user.update(step2_params)
        redirect_to onboarding_path(step: next_step)
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :show
      end
    when 'step3'
      if @user.update(step3_params)
        redirect_to onboarding_path(step: next_step)
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :show
      end
    else
      redirect_to root_path, notice: "Invalid onboarding step"
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

  def previous_step
    case step
    when 'step2' then 'step1'
    when 'step3' then 'step2'
    # Add more steps as needed
    else
      # If there's no previous step, redirect to the first step
      'step1'
    end
  end


  def step1_params
    params.require(:user).permit(:first_name, :last_name, :title, :billing_city, :description, :profile_picture)
  end

  def step2_params
    # Replace these with the actual parameters for step2
    params.require(:user).permit(:param1, :param2, :param3)
  end

  def step3_params
    # Replace these with the actual parameters for step3
    params.require(:user).permit(:param1, :param2, :param3)
  end

end
