class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[update]

  def create
    sub_params = {
      endpoint: subscription_params[:endpoint],
      p256dh_key: subscription_params[:keys][:p256dh],
      auth_key: subscription_params[:keys][:auth],
      device_id: subscription_params[:device_id]
    }
    if current_user.subscriptions.create(sub_params)
      render json: { status: 'ok' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.subscriptions.destroy_all
      render json: { status: 'ok' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def update
    @subscription = current_user.subscriptions.find_by(device_id: params[:device_id])
    sub_params = {
      endpoint: params[:new_subscription][:endpoint],
      p256dh_key: params[:new_subscription][:keys][:p256dh],
      auth_key: params[:new_subscription][:keys][:auth],
    }
    if @subscription && @subscription.update(sub_params)
      render json: { status: 'ok' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:endpoint, :expirationTime, :device_id, keys: %i[p256dh auth])
  end
end
