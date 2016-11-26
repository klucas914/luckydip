class AddLocationTypesLocations < ActiveRecord::Migration[5.0]
  def change
  	create_table :location_types_locations do |t| 
    	t.belongs_to :location_type, null: false, index: true, foreign_key: true
    	t.belongs_to :location, null: false, index: true, foreign_key: true
    end
  end
end
