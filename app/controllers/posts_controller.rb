class PostsController < ApplicationController
  # before_action :set_post, only: [:show]

  def index
    @post = Post.new
    @posts = policy_scope(Post).order(created_at: :desc)

    if user_signed_in?
      @myposts = current_user.posts.order(created_at: :desc)
      @professionals_posts = Post.where(team_id: current_user.following_by_type('Team').pluck(:id)).or(Post.where(people_id: current_user.following_by_type('Person').pluck(:id))).order(created_at: :desc)
    else
      @myposts = Post.all.order(created_at: :desc)
      @professionals_posts = Post.all
    end
  end

  def new
    @post = Post.new
    # if params contains info about the post which is to be created,
    # set values to @post before rendering.
    @post.title = params[:title] if params.include?(:title)
    @post.content = params[:content] if params.include?(:content)
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.people_id = params[:post][:person_id]
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
  # upvote from user

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_from current_user
    respond_to do |format|
      format.html { redirect_to posts_path(@post) }
      format.js
    end
    # @post = policy_scope(Post).order(created_at: :desc)
  end
  # downvote from user

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_from current_user
    respond_to do |format|
      format.html { redirect_to posts_path(@post) }
      format.js
    end
    # @post = policy_scope(Post).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :category, :photo, :user_generated, :content, :team_id)
  end

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end
end
