class AddReferencesToSelections < ActiveRecord::Migration[5.0]
  def change
    add_reference :selections, :location, foreign_key: true
    add_reference :selections, :activity, foreign_key: true
  end
end
