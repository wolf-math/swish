class Team < ApplicationRecord
  has_many :people
  acts_as_followable
end
