class AddConfLossToTeams < ActiveRecord::Migration[5.2]
  def change
        add_column :teams, :conf_loss, :integer
  end
end
