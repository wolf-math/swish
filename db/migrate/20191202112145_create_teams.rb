class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :nickname
      t.string :city
      t.string :state
      t.string :abbrevation
      t.string :api_team_id
      t.string :image_url

      t.timestamps
    end
  end
end
