class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def spotify
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      affect_spotify_tokens!(request.env["omniauth.auth"].credentials)
      sign_in_and_redirect @user # this will throw if @user is not activated
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

  private

  def affect_spotify_tokens!(credentials)
    @user.refresh_token = credentials.refresh_token
    @user.token = credentials.token
    @user.save!
  end
end
