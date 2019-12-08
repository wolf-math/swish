class AddPlayerIdToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :player_id, :string
  end
end
