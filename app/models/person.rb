class Person < ApplicationRecord
  acts_as_followable
  belongs_to :team, foreign_key: 'teams_id'
end
