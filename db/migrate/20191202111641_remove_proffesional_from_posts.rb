class RemoveProffesionalFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :professional_id, :reference
  end
end
