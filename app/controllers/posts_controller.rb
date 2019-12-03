class PostsController < ApplicationController
  def index
    @posts = policy_scope(Post).order(created_at: :desc)
    @people_posts = []
    @favorites = current_user.favorites
    @favorites.each do |fav|
      @people_posts << fav.people.posts
    end
    @people_posts.flatten! unless @people_posts == nil
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
