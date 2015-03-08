class OmniauthCallbackController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!

  def twitter
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect(user)
    else
      redirect_to root_path
    end
  end

  def failure
    super
  end

end
