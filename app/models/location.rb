class Location < ApplicationRecord
  has_many :dips, through: selections
end
