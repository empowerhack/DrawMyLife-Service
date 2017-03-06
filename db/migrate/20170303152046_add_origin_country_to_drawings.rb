class AddOriginCountryToDrawings < ActiveRecord::Migration
  def change
    add_column :drawings, :origin_country, :string
  end
end
