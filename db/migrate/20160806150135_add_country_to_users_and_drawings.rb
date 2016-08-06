class AddCountryToUsersAndDrawings < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :drawings, :country, :string
  end
end
