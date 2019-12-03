class DropTableProfessionals < ActiveRecord::Migration[5.2]
  def change
    drop_table :professionals
  end
end
