class Location < ApplicationRecord
  has_many :dips, through: :selections
  has_many :activities
  has_many :location_types
end
