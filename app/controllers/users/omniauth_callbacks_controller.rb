# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  # def google_oauth2
  #   user = User.from_omniauth(auth)
  #   if user.present?
  #     sign_out_all_scopes
  #     flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect user, event: :authentication
  #   else
  #     flash[:alert] =
  #       t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
  #     redirect_to new_user_session_path
  #   end
  # end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      auth = request.env["omniauth.auth"]
      @user.access_token = auth.credentials.token
      @user.expires_at = auth.credentials.expires_at
      @user.refresh_token = auth.credentials.refresh_token
      @user.save!
      sign_in(@user)
      redirect_to bookings_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except!(:extra)
      redirect_to new_user_registration_url
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  # def auth
  #   @auth ||= request.env['omniauth.auth']
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
