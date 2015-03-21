class GroupsController < ApplicationController

  def index
    render json: current_user.groups
  end

  def create
    current_user.groups.create!(group_params)
    render nothing: true, status: 201 and return
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end
