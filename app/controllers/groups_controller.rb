class GroupsController < ApplicationController

  def index
    render json: current_user.groups.includes(:friends)
  end

  def create
    group = current_user.groups.create!(group_params)
    render json: group, status: 201 and return
  end

  def destroy
    group = Group.find(params['id'])
    group.destroy!
    render json: {}, status: 200
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end
