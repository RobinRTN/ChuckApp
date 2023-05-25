class UsersController < ApplicationController

  before_action :authenticate_user!

  def edit_info
    @user = current_user
  end

  def update_info
    @user = current_user
    if @user.update(user_info_params)
      redirect_to edit_info_users_path, notice: 'Vos informations ont bien été mises à jour !'
    else
      render :edit_info
    end
  end

  def edit_dispo
    @user = current_user
  end

  def update_dispo
    @user = current_user
    if @user.update(user_dispo_params)
      redirect_to edit_dispo_users_path, notice: 'Vos disponibilités ont bien été mises à jour !'

    else
      render :edit_dispo
    end
  end

  def edit_indispo
    @user = current_user
  end

  def update_indispo
    @user = current_user
    if @user.update(user_indispo_params)
      redirect_to edit_indispo_users_path, notice: 'Vos indisponibilités ont bien été mises à jour !'
    else
      render :edit_indispo
    end
  end

  private

  def user_info_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :title, :billing_city, :description)
  end

  def user_dispo_params
    params.require(:user).permit(:daily_start_time, :daily_end_time).tap do |whitelisted|
      whitelisted[:days_of_week] = params[:user][:days_of_week].split(',')
    end
  end


  def user_indispo_params
    params.require(:user).permit(:excluded_fixed_weekly_slots)
  end

end
