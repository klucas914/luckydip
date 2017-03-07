class Dip < ApplicationRecord
 
  belongs_to :activity
  belongs_to :location_type
  has_many :selections
  has_many :locations, through: :selections
end
