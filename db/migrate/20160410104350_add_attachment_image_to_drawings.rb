class AddAttachmentImageToDrawings < ActiveRecord::Migration
  def self.up
    change_table :drawings do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :drawings, :image
  end
end
