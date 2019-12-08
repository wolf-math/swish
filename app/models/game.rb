class Game < ApplicationRecord
  belongs_to :vTeam, class_name: "Team"
  belongs_to :hTeam, class_name: "Team"
end
