class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :team, optional:true
  belongs_to :person, optional:true
  # belongs_to :people, source: "Person"
  has_many :comments, as: :commentable
  validates :title, presence: true
  mount_uploader :photo, PhotoUploader
  acts_as_votable

def upvote
  @post = Post.find(params[:id])

  if current_user.up_votes @post
    @post.unvote_up current_user
  else
    @post.upvote_by current_user
  end

  @post.create_activity :upvote, owner: current_user
end

  def person_id
    people_id
  end

end

