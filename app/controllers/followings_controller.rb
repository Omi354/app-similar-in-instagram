class FollowingsController < ApplicationController
  def show
    @user = User.find(params[:account_id])
    @followings = @user.followings
  end
end