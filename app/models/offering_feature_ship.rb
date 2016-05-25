class OfferingFeatureShip < ActiveRecord::Base
  belongs_to :feature
  belongs_to :cache_offering
end
