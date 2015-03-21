class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  before_filter :authenticate_user!, :except => [:login]

  def after_sign_in_path_for(resource)
    home_path
  end

end
