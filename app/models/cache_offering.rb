class CacheOffering < ActiveRecord::Base
	has_many :observations
	has_and_belongs_to_many :observedProperty

  validates :offering, :procedure, :beginTime, :endTime, presence: true

end
