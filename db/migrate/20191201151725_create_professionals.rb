class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.string :name
      t.string :role
      t.references :team
      t.string :image_url

      t.timestamps
    end
  end
end
