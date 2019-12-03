class PostsController < ApplicationController
  def index
    @posts = policy_scope(Post).order(created_at: :desc)
    @professionals_posts = []
    @favorites = current_user.favorites
    @favorites.each do |fav|
      @professionals_posts << fav.professional.posts
    end
    @professional_posts.flatten! unless @professional_posts == nil
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

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :category, :image_url, :user_generated, :content)
  end
end