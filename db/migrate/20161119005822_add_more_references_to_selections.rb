class AddMoreReferencesToSelections < ActiveRecord::Migration[5.0]
  def change
    add_reference :selections, :location_type, foreign_key: true
    add_reference :selections, :dip, foreign_key: true
  end
end
