class AddConsentToDrawings < ActiveRecord::Migration
  def change
    add_column :drawings, :image_consent, :boolean, null: false, default: false
  end
end
