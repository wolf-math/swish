class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  rename_column :people, :image_url, :photo
  end
end
