class AddLocationAndOrgIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :organisation_id, :integer
    add_column :users, :location_id, :integer
  end
end
