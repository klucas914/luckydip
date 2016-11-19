class AddReferencesToLocation < ActiveRecord::Migration[5.0]
  def change
    add_reference :locations, :activity, foreign_key: true
    add_reference :locations, :location_type, foreign_key: true
  end
end
