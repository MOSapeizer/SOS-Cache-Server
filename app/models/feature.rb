class Feature < ActiveRecord::Base
  has_many :offering_prorperty_ships
  has_many :cache_offerings, through: :offering_feature_ships
end
