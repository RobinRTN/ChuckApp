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

  private

  def user_info_params
    params.require(:user).permit(:email, :first_name, :last_name) # add here the fields that can be updated
  end
end
