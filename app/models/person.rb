class Person < ApplicationRecord
  belongs_to :team, foreign_key: 'teams_id'
end
