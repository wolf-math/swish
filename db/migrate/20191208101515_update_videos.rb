class UpdateVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :videoid, :string
    add_column :videos, :description, :string
    add_column :videos, :thumbnail, :string
    add_reference :videos, :user, foreign_key: true
  end
end
