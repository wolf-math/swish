class Team < ApplicationRecord
  has_many :people
  acts_as_followable
  has_many :away_games, class_name: "Game", foreign_key: "vTeam_id"
  has_many :home_games, class_name: "Game", foreign_key: "hTeam_id"

  def team_name
    name + " " + nickname
  end

  def team_nickname
    nickname
  end
end
