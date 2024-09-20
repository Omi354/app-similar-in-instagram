class FollowersController < ApplicationController
  def show
    @user = User.find(params[:account_id])
    @followers = @user.followers
  end
end