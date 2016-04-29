require_relative '../swes/offering.rb'

module SOSHelper
	class Contents
		def initialize(contents)
			@contents = contents
		end

		def offerings
			offerings = @contents.xpath("//swes:offering")
			@offering = @offering || get(offerings) || []
		end

		def get(offerings)
			offerings.map { |offering| SWES::Offering.new(offering) }
		end

		def procedureDescriptionFormat

		end

		def observableProperty

		end

		def relatedFeature

		end

		def responseFormat

		end

		def featureOfInterestType

		end

		def observationType

		end
	end
end