class GroupsController < ApplicationController

  def index
    render json: current_user.groups
  end

  def create
    group = current_user.groups.create!(group_params)
    render json: group, status: 201 and return
  end

  def add_friend
    group = Group.find(params['id'])
    friend = Friend.find(params['friend_id'])
    result = group.friends.push(friend)
    render json: {}, status: 200 and return if result
    render json: {}, status: 500
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
