class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :team, optional:true
  belongs_to :person, optional:true
  # belongs_to :people, source: "Person"
  has_many :comments, as: :commentable
  validates :title, presence: true
  mount_uploader :photo, PhotoUploader

  def person_id
    people_id
  end
end
