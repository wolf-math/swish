class RemoveApiTeamIdFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :api_team_id, :string
  end
end
