class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :professional, optional: true
  has_many :comments, as: :commentable
  validates :title, presence: true
  mount_uploader :photo, PhotoUploader
  acts_as_votable
end
def upvote
  @post = Post.find(params[:id])

  if current_user.up_votes @post
    @post.unvote_up current_user
  else
    @post.upvote_by current_user
  end

  @post.create_activity :upvote, owner: current_user
end
