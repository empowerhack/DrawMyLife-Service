class ChangeGenderTypeInDrawings < ActiveRecord::Migration
  def up
    remove_column :drawings, :gender
    add_column :drawings, :gender, :integer, default: 0
  end

  def down
    remove_column :drawings, :gender
    add_column :drawings, :gender, :string
  end
end
