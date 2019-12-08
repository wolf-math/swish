class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :date
      t.references :vTeam, foreign_key: { to_table: 'teams' }
      t.references :hTeam, foreign_key: { to_table: 'teams' }
      t.integer :hTeamScore
      t.integer :vTeamScore

      t.timestamps
    end
  end
end
