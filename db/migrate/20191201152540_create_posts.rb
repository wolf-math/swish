class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :professional, foreign_key: true
      t.string :title
      t.string :category
      t.string :image_url
      t.boolean :user_generated
      t.text :content
      t.integer :likes

      t.timestamps
    end
  end
end
