class FriendsController < ApplicationController

  def index
    render json: current_user.friends
  end

  def update_all
    current_user.refresh_friends!
    render json: {success: true}
  end

end
