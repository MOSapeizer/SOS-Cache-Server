class CacheOffering < ActiveRecord::Base
	has_many :observations
  has_many :offering_prorperty_ships
  has_many :offering_feature_ships
  has_many :features, through: :offering_feature_ships
	has_many :cache_observed_properties, through: :offering_prorperty_ships

  validates :offering, :procedure, :beginTime, :endTime, presence: true

end
