class Activity < ApplicationRecord
  belongs_to :dip
  has_many :locations
end
