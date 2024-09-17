class LikesController < ApplicationController
  before_action :authenticate_user!

  def show
    # もしそのポストのlikeが存在したらtrue,しなければfalseを返す
    like = current_user.likes.find_by(post_id: params[:post_id])
    render json: {
      has_like: like.present?
    }
  end

  def create
    like = current_user.likes.build(post_id: params[:post_id])
    like.save!
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy!
  end

end
