class TimelinesController < ApplicationController

  def show
    render json: current_user.organized_tweets.as_json
  end

  def refresh
    current_user.refresh_tweets!
    render json: {}, status: 204
  end

end
