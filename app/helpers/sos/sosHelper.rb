require 'nokogiri'
require 'set'
require_relative 'boss'
require_relative 'factory'
require_relative 'capability'
require_relative 'observation'

module SOSHelper
	Urls = ["http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service",
			  "http://cgis.csrsr.ncu.edu.tw:8080/epa-sos/service",
			  "http://cgis.csrsr.ncu.edu.tw:8080/epa-aqx-sos/service"].freeze

	Relics = ["offering","observedProperty",
	     "featureOfInterest",
		 "procedure", "spatialFilter", 
		 "temporalFilter", "responseFormat"].freeze

	fpath = File.dirname(__FILE__) + "/request/getObservation.xml"
	ObservationRequest = File.open( fpath ) { |f| Nokogiri::XML(f)  }.freeze
	
end

# o = SOSHelper::GetObservation.new
# o.filter({:offering => "鳳義坑"}).filter({:observedProperty => "urn:ogc:def:phenomenon:OGC:1.0.30:rainfall_1day"})
# c = o.filter({:temporalFilter => :during })
# p c