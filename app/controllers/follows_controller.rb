class FollowsController < ApplicationController
  before_action :authenticate_user!

  def show
    following_relationship = current_user.following_relationships.find_by(following_id: params[:account_id])
    followStatus = following_relationship.present?
    render json: {
      follow: followStatus
    }
  end

  def create
    # accounts/showからpostリクエストがくる。follwer_id: :current_user.id, following_id: params[:account_id]　となるようなデータを作成
    following_relationship = current_user.following_relationships.build(following_id: params[:account_id])
    following_relationship.save
    render json: {
      msg: 'フォローしました'
    }
  end
end