class AddConfAndStandingToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :conference, :string
    add_column :teams, :standing, :integer
  end
end
