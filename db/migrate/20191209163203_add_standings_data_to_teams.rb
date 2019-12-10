class AddStandingsDataToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :win_percent, :float
    add_column :teams, :games_behind, :float
    add_column :teams, :conf_win, :integer
    add_column :teams, :last10wins, :integer
    add_column :teams, :last10loss, :integer
    add_column :teams, :streak, :integer
    add_column :teams, :streak_wins, :boolean
  end
end
