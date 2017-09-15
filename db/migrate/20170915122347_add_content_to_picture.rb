class AddContentToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :content, :text
  end
end
