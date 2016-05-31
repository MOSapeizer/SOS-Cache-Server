class OfferingProrpertyShip < ActiveRecord::Base
  belongs_to :cache_offering
  belongs_to :observed_property
end
