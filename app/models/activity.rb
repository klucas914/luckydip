class Activity < ApplicationRecord
  has_many :dips
  has_many :locations
  has_many :location_types, :through => :locations
end
