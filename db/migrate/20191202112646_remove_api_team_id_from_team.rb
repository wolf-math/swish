class RemoveApiTeamIdFromTeam < ActiveRecord::Migration[5.2]
  def change
        remove_column :teams, :api_team_id, :string
  end
end
