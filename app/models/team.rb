class Team < ApplicationRecord
  has_many :people
  acts_as_followable

  def team_name
    name + " " + nickname
  end

  def team_nickname
    nickname
  end
end
