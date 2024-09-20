class FollowsController < ApplicationController
  def create
    # accounts/showからpostリクエストがくる。follwer_id: :current_user.id, following_id: params[:account_id]　となるようなデータを作成
    following_relationship = current_user.following_relationships.build(following_id: params[:account_id])
    following_relationship.save
  end
end