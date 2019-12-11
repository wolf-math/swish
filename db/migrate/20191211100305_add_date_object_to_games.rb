class AddDateObjectToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :date_time, :date
  end
end
