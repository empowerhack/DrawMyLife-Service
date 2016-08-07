class AddStatusToDrawings < ActiveRecord::Migration
  def change
    add_column :drawings, :status, :integer, default: 0, index: true
  end
end
