class Post < ApplicationRecord
  belongs_to :user
  belongs_to :professional

  has_many :comments, as: :commentable
end
