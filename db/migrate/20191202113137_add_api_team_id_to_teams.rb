class AddApiTeamIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :api_team_id, :string
  end
end
