class Location < ApplicationRecord
  has_many :dips, through: :selections
  has_many :activities
  has_many :location_types

   geocoded_by :address, :latitude => :lat, :longitude => :lon   # can also be an IP address
   after_validation :geocode, if: ->(location){ location.address.present? and location.address_changed? }          # auto-fetch coordinates


end
