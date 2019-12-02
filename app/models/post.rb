class Post < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :professional, optional: true

  has_many :comments, as: :commentable
end
