class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def show
    
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      flash.now[:error] = 'Failed to create the post'
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:caption, images: [])
  end
end