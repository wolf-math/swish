class Person < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  acts_as_followable
  belongs_to :team, foreign_key: 'team_id'

  def full_name
    first_name + " " + last_name
  end
end
