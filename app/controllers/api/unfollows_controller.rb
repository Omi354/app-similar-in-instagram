class Api::UnfollowsController < Api::ApplicationController
  before_action :authenticate_user!

  def create
    # accounts/showからpostリクエストがくる。follwer_id: :current_user.id, following_id: params[:account_id]　となるようなデータを作成
    following_relationship = current_user.following_relationships.find_by(following_id: params[:account_id])
    following_relationship.destroy!
    render json: {
      msg: 'アンフォローしました'
    }
  end
end