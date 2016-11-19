class Dip < ApplicationRecord
  has_one :activity
  has_one :location_type
  has_many :locations, through: :selections
end
