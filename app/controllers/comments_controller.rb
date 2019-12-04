class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comments_params)
    @post = Post.find(params[:post_id])
    @comment.commentable = @post
    @comment.user = current_user
    authorize @comment
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
