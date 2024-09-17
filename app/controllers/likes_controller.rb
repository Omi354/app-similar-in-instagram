class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:show, :destroy]

  def show
    # もしそのポストのlikeが存在したらtrue,しなければfalseを返す
    render json: {
      has_like: @like.present?
    }
  end

  def create
    like = current_user.likes.build(post_id: params[:post_id])
    like.save!
    render json: {
      has_like: like.present?
    }
  end

  def destroy
    @like.destroy!
    render json: {
      has_like: !@like.destroyed? #destroyをしてもpresent?で確認するとメモリ上のオブジェクトは残っているのでtureで返されてしまう
    }
  end

  private
  def set_like
    @like = current_user.likes.find_by(post_id: params[:post_id])
  end

end
