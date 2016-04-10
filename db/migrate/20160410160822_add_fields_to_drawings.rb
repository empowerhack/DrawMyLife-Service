class AddFieldsToDrawings < ActiveRecord::Migration
  def change
    add_reference :drawings, :location, index: true, foreign_key: true
    add_column :drawings, :mood_rating, :integer
    add_column :drawings, :age, :integer
    add_column :drawings, :gender, :string
    add_column :drawings, :subject_matter, :string
    add_column :drawings, :story, :text
  end
end
