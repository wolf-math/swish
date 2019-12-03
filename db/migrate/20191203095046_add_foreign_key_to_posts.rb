class AddForeignKeyToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :people, foreign_key: true
    add_reference :posts, :team, foreign_key: true
  end
end
