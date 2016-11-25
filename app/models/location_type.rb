class LocationType < ApplicationRecord
  has_many :dips
  has_many :locations
  has_many :activities, :through => :locations
end
