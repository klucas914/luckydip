class Location < ApplicationRecord
  has_many :dips, through: :selections
  belongs_to :activity
  belongs_to :location_type
  has_many :reviews

  geocoded_by :address#, latitude::lat, longitude::lon   # can also be an IP address
  
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }          # auto-fetch coordinates


end
