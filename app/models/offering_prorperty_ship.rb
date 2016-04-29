class OfferingProrpertyShip < ActiveRecord::Base
  belongs_to :cache_offering
  belongs_to :cache_observed_property
end
