class RemoveNameFromDrawings < ActiveRecord::Migration
  def change
    remove_column :drawings, :name
  end
end
