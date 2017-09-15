class AddAttachmentFileToBrochures < ActiveRecord::Migration
  def self.up
    change_table :brochures do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :brochures, :file
  end
end
