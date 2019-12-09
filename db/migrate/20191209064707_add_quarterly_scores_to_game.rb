class AddQuarterlyScoresToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :vteam_q1, :integer
    add_column :games, :vteam_q2, :integer
    add_column :games, :vteam_q3, :integer
    add_column :games, :vteam_q4, :integer
    add_column :games, :hteam_q1, :integer
    add_column :games, :hteam_q2, :integer
    add_column :games, :hteam_q3, :integer
    add_column :games, :hteam_q4, :integer
  end
end
