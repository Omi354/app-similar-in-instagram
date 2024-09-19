class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments, include: ['user.profile']
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save!
    render json: @comment, include: ['user.profile']

  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
