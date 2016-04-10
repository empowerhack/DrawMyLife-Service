class AddUserIdToDrawings < ActiveRecord::Migration
  def change
    add_reference :drawings, :user, index: true, foreign_key: true
  end
end
