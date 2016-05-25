require 'nokogiri'
require 'set'
require_relative 'boss'
require_relative 'factory'
require_relative 'capability'
require_relative 'observation'

module SOSHelper
	Urls = %w(http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service http://cgis.csrsr.ncu.edu.tw:8080/epa-sos/service http://cgis.csrsr.ncu.edu.tw:8080/epa-aqx-sos/service).freeze

	Relics = %w(offering observedProperty featureOfInterest procedure spatialFilter temporalFilter responseFormat).freeze

	ObsRequestPath = File.dirname(__FILE__) + '/request/getObservation.xml'
	FeatureRequestPath = File.dirname(__FILE__) + '/request/getFeatureOfInterest.xml'
	ObservationRequest = File.open( ObsRequestPath ) { |f| Nokogiri::XML(f) }.freeze
	FeatureRequest = File.open( FeatureRequestPath ) { |f| Nokogiri::XML(f) }.freeze

	class Tag

    def initialize
      @offering = ''
      @property = ''
      @temporal = ''
			@feature = ''
    end

		def offering(values=[])
			return nil if values.empty?
			result = values_map 'offering', values
			@offering += result.join('  ')
		end

		def feature(values=[])
			return nil if values.empty?
			result = values_map 'featureOfInterest', values
			@feature += result.join('  ')
		end

		def property(values=[])
			return nil if values.empty?
			result = values_map 'observedProperty', values
			@property += result.join('  ')
		end

		def values_map(tag_name, values)
			values.map do |value|
				" <sos:#{tag_name}>" + value + "</sos:#{tag_name}> "
			end
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
      @offering + @property + @feature + @temporal
    end

	end

end