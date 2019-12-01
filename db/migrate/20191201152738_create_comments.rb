class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.text :text
      t.integer :likes
      t.integer :commentable_id

      t.timestamps
    end
  end
end
