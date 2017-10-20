class AddUserToBrochure < ActiveRecord::Migration
  def change
    add_reference :brochures, :user, index: true, foreign_key: true
  end
end
