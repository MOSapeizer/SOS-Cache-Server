class ObservedProperty < ActiveRecord::Base
  has_many :offering_prorperty_ships
	has_many :cache_offerings, through: :offering_prorperty_ships
	validates :property, presence: true
end
