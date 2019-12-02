class Post < ApplicationRecord
  belongs_to :user
  belongs_to :professional, optional: true

  has_many :comments, as: :commentable
end
