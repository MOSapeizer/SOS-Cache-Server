require_relative 'xmlRequest.rb'
require_relative 'sosHelper.rb'

# Usage:
# 	s = SOS.new("Url")
# 	s.getCapabilities  => return All capabilities
# 	s.getObservations(condition)
#       => set the filter to get observations
# 	s.offering =>  return all offerings from @capability

# 	url = "http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service"
#   s  = SOS.new("YourService")

module Core
	class SOS
		attr_reader :capabilities
		def initialize(url, args={})
			# request to http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service
			@request = XmlRequest.new(url)
			@capabilities = nil
			@observations, @gf, @gc, @go = nil

		end

		def getCapabilities(query={})
			@gc = SOSHelper::GetCapability.new(request: @request)
			@gc.send
			@capabilities = @gc.capabilities
		end

		def getObservations
			@go = SOSHelper::GetObservation.new(request: @request)
		end

		def getFeatureOfInterest
			@gf = SOSHelper::GetFeatureOfInterest.new(request: @request)
		end

		def offerings
			@offerings ||= @capabilities.contents.offerings
		end
	end
end