class GroupsController < ApplicationController
  def index
    render json: current_user.groups
  end
end
