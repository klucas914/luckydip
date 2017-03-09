class Dip < ApplicationRecord
 
  belongs_to :activity
  belongs_to :location_type
  has_many :selections
  has_many :locations, through: :selections


  def matching_locations(lat, long)
  
  	Location
  	  .joins("LEFT JOIN activities_locations ON locations.id=activities_locations.location_id")
  	  .joins("LEFT JOIN location_types_locations ON locations.id=location_types_locations.location_id")
  	  .where('activities_locations.activity_id IN (?) AND location_types_locations.location_type_id IN (?)', activity_id, location_type_id)
  	  .near([lat, long], 100)
  end


end
