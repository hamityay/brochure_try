class CreateBrochures < ActiveRecord::Migration
  def change
    create_table :brochures do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
