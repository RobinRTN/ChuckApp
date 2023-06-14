class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

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

  def index
    @groups = current_user.groups
  end

  def show
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      redirect_to @group, notice: 'Groupe créé avec succès !'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Groupe modifié !'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Groupe supprimé !.'
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, client_ids: [])
  end
end
