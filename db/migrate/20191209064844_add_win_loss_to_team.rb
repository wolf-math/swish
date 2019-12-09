class AddWinLossToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :wins, :integer
    add_column :teams, :losses, :integer
  end
end
