class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comments_params)
    ## CHECK if the params contain :post_id OR :comment_id
    if params.include?(:post_id)
      @post = Post.find(params[:post_id])
      @comment.commentable = @post
    else
      @parent_comment = Comment.find(params[:comment_id])
      @comment.commentable = @parent_comment
      # Find the post at the top of the chain!
      @post = @parent_comment.post_ancestor
    end
    @comment.user = current_user
    authorize @comment
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'posts/show'}
        format.js
      end
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
