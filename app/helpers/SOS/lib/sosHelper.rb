require 'nokogiri'
require 'set'
require_relative 'boss'
require_relative 'factory'
require_relative 'capability'
require_relative 'observation'

module SOSHelper
	Urls = %w(http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service http://cgis.csrsr.ncu.edu.tw:8080/epa-sos/service http://cgis.csrsr.ncu.edu.tw:8080/epa-aqx-sos/service).freeze

	Relics = %w(offering observedProperty featureOfInterest procedure spatialFilter temporalFilter responseFormat).freeze

	fpath = File.dirname(__FILE__) + '/request/getObservation.xml'
	ObservationRequest = File.open( fpath ) { |f| Nokogiri::XML(f)  }.freeze

	class Tag

    def initialize
      @offering = ''
      @property = ''
      @temporal = ''
    end

		def offering(values=[])
      result = values.map do |value|
				' <sos:offering>' + value + '</sos:offering> '
			end
			@offering += result.join('  ')
		end

		def property(values=[])
			result = values.map do |value|
				' <sos:observedProperty>' + value + '</sos:observedProperty> '
			end
			@property += result.join('  ')
		end

		def temporal(id, time)
      time = time.split(' ')
			@temporal = ' <sos:temporalFilter>' +
                    ' <fes:During>' +
                      ' <fes:ValueReference>phenomenonTime</fes:ValueReference>' +
                          ' <gml:TimePeriod gml:id="' + id + '">' +
                            ' <gml:beginPosition>' + time[0] + '</gml:beginPosition>' +
                            ' <gml:endPosition>' + time[1] + '</gml:endPosition>' +
                          ' </gml:TimePeriod>' +
                      ' </fes:During>' +
                  ' </sos:temporalFilter>'
    end

    def output
      @offering + @property + @temporal
    end

	end

end