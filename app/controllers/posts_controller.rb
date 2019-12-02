class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      raise
      # render 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :category, :image_url, :user_generated, :content)
  end
end
