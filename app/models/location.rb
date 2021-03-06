class Location < ApplicationRecord
  
  has_many :selections
  has_many :dips, through: :selections
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :location_types
  has_many :reviews
  has_and_belongs_to_many :users
  has_many :check_ins, dependent: :destroy

  geocoded_by :address#, latitude::lat, longitude::lon   # can also be an IP address
  
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }          # auto-fetch coordinates

  include HTTParty
end
