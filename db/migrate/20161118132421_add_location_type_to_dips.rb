class AddLocationTypeToDips < ActiveRecord::Migration[5.0]
  def change
    add_reference :dips, :location_type, foreign_key: true
  end
end
