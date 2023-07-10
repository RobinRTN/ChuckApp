class UsersController < ApplicationController

  before_action :authenticate_user!
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
    @previous_page = params[:previous_page]
  end

  def update_dispo
    @user = current_user
    @previous_page = params[:user][:previous_page] # get previous_page value from parameters
    if @user.update(user_dispo_params)
      redirect_to edit_dispo_users_path(previous_page: @previous_page), notice: 'Vos disponibilités ont bien été mises à jour !'
    else
      render :edit_dispo
    end
  end

  def edit_indispo
    @user = current_user
    @previous_page = params[:previous_page]
  end

  def edit_formules
    @user = current_user
    @previous_page = params[:previous_page]
  end

  def update_formules
    # @user = current_user
    # if @user.update(user_formule_params)
    #   redirect_to edit_formules_users_path, notice: 'Vos prestations ont bien été mises à jour !'
    # else
    #   redirect_to edit_formules_users_path
    #   logger.error "Error updating formules: #{@user.errors.full_messages.join(', ')}"
    # end
    @user = current_user
    params[:user][:formules_attributes].each do |id, formule_attributes|
      if formule_attributes[:_destroy] == '1'
        formule = Formule.find(formule_attributes[:id])
        formule.update(deleted_at: Time.current, archived: true)  # Soft delete the formule and mark it as archived
        formule_attributes[:_destroy] = '0'  # Prevent Rails from automatically deleting the record
      end
    end
    if @user.update(user_formule_params)
      redirect_to edit_formules_users_path, notice: 'Vos prestations ont bien été mises à jour !'
    else
      redirect_to edit_formules_users_path
      logger.error "Error updating formules: #{@user.errors.full_messages.join(', ')}"
    end
  end

  def update_indispo
    @user = current_user
    @previous_page = params[:user][:previous_page] # get previous_page value from parameters
    if @user.update(user_indispo_params)
      redirect_to edit_indispo_users_path(previous_page: @previous_page), notice: 'Vos indisponibilités ont bien été mises à jour !'
    else
      render :edit_indispo
    end
  end

  def delete_gallery
    user = current_user

    # Get the image by key
    image_attachment = user.gallery_pictures.joins(:blob).find_by(active_storage_blobs: { key: params[:image_key] })

    # Delete the image
    if image_attachment
      image_attachment.purge
      flash[:notice] = "Image supprimée"
    else
      flash[:alert] = "Image non trouvée"
    end
    # Redirect back to the previous page
    redirect_to profile_path
  end

  def add_gallery
    user = current_user
    if params[:gallery_pictures]
      params[:gallery_pictures].each do |image|
        user.gallery_pictures.attach(image)
      end
    end
    respond_to do |format|
      format.html { redirect_to profile_path, notice: "Images added successfully" }
      format.js { render js: 'window.location.reload();' }
    end
  end

  def update_profile_picture
    if params[:profile_picture]
      current_user.profile_picture.attach(params[:profile_picture])
      flash[:notice] = "Photo de profil modifiée avec succès"
    else
      flash[:alert] = "Aucune image selectionnée"
    end
    redirect_to profile_path
  end

  def finish_onboarding
    current_user.update(needs_onboarding: false)
    head :ok # This sends an empty response with a 200 OK status
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

  def user_formule_params
    # params.require(:user).permit(formules_attributes: [:id, :name, :price, :duration, :description, :_destroy])
    params.require(:user).permit(formules_attributes: [:id, :name, :price, :duration, :description, :deleted_at, :archived])

  end


  def user_indispo_params
    params.require(:user).permit(:excluded_fixed_weekly_slots)
  end

end
