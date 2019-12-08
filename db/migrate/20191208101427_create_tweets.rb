class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :text
      t.string :name
      t.string :handle
      t.integer :followers
      t.string :avatar
      t.date :posted_at
      t.string :url
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
