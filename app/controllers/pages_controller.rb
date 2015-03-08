class PagesController < ApplicationController
  def login
    redirect_to home_path if user_signed_in?
  end

  def home
  end
end
