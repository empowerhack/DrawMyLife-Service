class DropLocationsTable < ActiveRecord::Migration
  def up
    remove_column :drawings, :location_id
    remove_column :users, :location_id
    drop_table :locations
  end

  def down
    create_table :locations do |t|
      t.string :country
      t.timestamps null: false
    end
    add_reference :drawings, :location, index: true, foreign_key: true
    add_reference :users, :location, index: true, foreign_key: true
  end
end
