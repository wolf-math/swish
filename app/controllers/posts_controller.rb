class PostsController < ApplicationController
  # before_action :set_post, only: [:show]

  def index
    @post = Post.new
    @posts = policy_scope(Post).order(created_at: :desc)
    @myposts = if user_signed_in?
                 current_user.posts.order(created_at: :desc)
                else
                  Post.all.order(created_at: :desc)
                end
    @professionals_posts = if user_signed_in?
                            Post.where(team_id: current_user.following_by_type('Team').pluck(:id)).or(Post.where(people_id: current_user.following_by_type('Person').pluck(:id))).order(created_at: :desc)
                          else Post.all
                          end
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
    @comment = Comment.new
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
