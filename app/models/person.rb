class Person < ApplicationRecord
  acts_as_followable
  belongs_to :team, foreign_key: 'teams_id'

  def full_name
    first_name + " " + last_name
  end
end
