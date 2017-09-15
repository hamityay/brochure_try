class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :order_number
      t.references :brochure, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
