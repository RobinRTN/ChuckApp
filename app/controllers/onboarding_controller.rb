class OnboardingController < ApplicationController
  before_action :authenticate_user!
  helper_method :step, :previous_step


  def show
    @user = current_user
    @user.packages.build unless @user.packages.present?
    @user.packages.each do |package|
      package.formules.build unless package.formules.present?
    end
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
        render "onboarding/step1", status: :unprocessable_entity
      end
    when 'step2'
      if @user.update(step2_params)
        redirect_to onboarding_path(step: next_step)
      else
        render "onboarding/step2", status: :unprocessable_entity
        flash[:error] = @user.errors.full_messages.join(", ")
      end
    when 'step3'
      if @user.update(step3_params)
        redirect_to onboarding_path(step: next_step)
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render "onboarding/step3", status: :unprocessable_entity
      end
    when 'step4'
      if @user.update(step4_params)
        redirect_to root_path
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render "onboarding/step4", status: :unprocessable_entity
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
    when 'step4' then 'step3'
    # Add more steps as needed
    else
      # If there's no previous step, redirect to the first step
      'step1'
    end
  end


  def step1_params
    params.require(:user).permit(:first_name, :last_name, :title, :billing_city, :description, :profile_picture, :phone_number, gallery_pictures: [])
  end

  def step2_params
    # Replace these with the actual parameters for step2
    params.require(:user).permit(:address, packages_attributes: [:id, :_destroy, :name, formules_attributes: [:id, :_destroy, :name, :price, :duration, :description, :address_line]])
  end

  def step3_params
    params.require(:user).permit(:daily_start_time, :daily_end_time).tap do |whitelisted|
      whitelisted[:days_of_week] = params[:user][:days_of_week].split(',')
    end
  end

  def step4_params
    params.require(:user).permit(:excluded_fixed_weekly_slots)
  end

end
