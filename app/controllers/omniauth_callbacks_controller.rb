class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def spotify
    p request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.refresh_token = request.env["omniauth.auth"].credentials.refresh_token
    @user.token = request.env["omniauth.auth"].credentials["token"]

    if @user.persisted?
      sign_in_and_redirect @user # this will throw if @user is not activated
      current_user = @user
      current_user.save
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = "La connexion a échoué. Merci de réessayer ultérieurement."
    redirect_to root_path
  end
end
