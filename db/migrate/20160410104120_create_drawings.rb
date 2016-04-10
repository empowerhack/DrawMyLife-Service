class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
