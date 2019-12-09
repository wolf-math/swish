class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :text, presence: true

  def post_ancestor
    parent = commentable
    return parent if parent.class.name == 'Post'

    return parent.post_ancestor
  end
end
