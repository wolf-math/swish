class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :jersey_number
      t.string :api_team_id
      t.string :position
      t.string :height
      t.references :teams, foreign_key: true
      t.string :image_url

      t.timestamps
    end
  end
end
