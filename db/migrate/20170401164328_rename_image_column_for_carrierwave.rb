class RenameImageColumnForCarrierwave < ActiveRecord::Migration
  def change
    rename_column :drawings, :image_file_name, :image
  end
end
