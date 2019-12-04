class PostsController < ApplicationController
  # before_action :set_post, only: [:show]

  def index
    @post = Post.new
    @posts = policy_scope(Post).order(created_at: :desc)

    @professionals_posts = []
    @favorites = current_user.all_following
    @favorites.each do |fav|
      @professionals_posts << Post.find_by(team_id: fav.id)
    end
    @professionals_posts.flatten! unless @professionals_posts == nil
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
    authorize @post
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :category, :image_url, :user_generated, :content)
  end

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end
end
