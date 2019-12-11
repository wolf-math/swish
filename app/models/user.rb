class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts
  acts_as_follower
  acts_as_voter
  mount_uploader :photo, PhotoUploader
  has_many :videos
  has_many :tweets

  def preferences
    all_follows.map do |follow|
      if follow.followable_type == "Team"
        Team.find(follow.followable_id).team_name
        Team.find(follow.followable_id).team_nickname
      else
        Person.find(follow.followable_id).full_name
      end
    end.sample(6)
  end
end
