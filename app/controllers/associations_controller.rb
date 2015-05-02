class AssociationsController < ApplicationController

  def create
    group  = Group.find(params['group_id'])
    friend = Friend.find(params['friend_id'])
    result = group.friends.push(friend)
    render json: {}, status: 200 and return if result
    render json: {}, status: 500
  end

end
