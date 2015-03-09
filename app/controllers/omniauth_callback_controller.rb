class OmniauthCallbackController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!

  def twitter
    if user_signed_in?
      current_user.enrich_oauth_info(env["omniauth.auth"])
      redirect_to '/pages/home'
    else
      redirect_to root_path
    end
  end

  def failure
    super
  end

end
