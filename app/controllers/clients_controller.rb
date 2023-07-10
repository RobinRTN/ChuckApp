class ClientsController < ApplicationController

  before_action :set_client, only: :update

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



  def new
    @client = Client.new
  end

  def index
    clients = current_user.clients.where(deleted_at: nil)
    @clients = clients.order(:full_name)
    groups = current_user.groups
    @groups = groups.order(:name)
  end

  def show
    @client = Client.find(params[:id])
    @all_bookings = @client.bookings.order(start_time: :desc)
    unless params[:format].nil?
      received_data = params[:format].split("/")
      @previous_page = received_data[0]
      @booking_id = received_data[1]
    end
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id
    if @client.save
      redirect_to clients_path
    else
      flash.alert = "Tous les champs doivent être complétés 🛠️"
    end
  end

  def update
    @client.update(client_params)
    redirect_to clients_path
  end

  def update_note
    @client = Client.find(params[:id])
    if @client.update(note: params[:note])
      render json: { status: 'success', note: @client.note }
    else
      render json: { status: 'error', errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def erase
    @client = Client.find(params[:id])
    @client.soft_delete
    redirect_to clients_path, notice: 'Contact client supprimé'
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :email, :photo)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
