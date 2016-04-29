class ObservedProperty < ActiveRecord::Base
	has_and_belongs_to_many :cache_offering
end
