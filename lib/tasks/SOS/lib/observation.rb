require 'json'

module SOSHelper

	class Observation
		def initialize(str)
			@xml = Nokogiri::XML(str)
		end

		def parse
      datalist = @xml.xpath('//sos:observationData')
			@output = datalist.map do |data|
        { procedure: check_value(data.xpath('.//om:procedure')),
          timeposition: data.xpath('.//gml:timePosition').text,
          featureOfInterest: check_value(data.xpath('.//om:featureOfInterest')),
          result: data.xpath('.//om:result').text }
			end
    end

    def check_value(tag)
      return tag.text.to_s if tag.text.to_s != ''
      tag.map do |child|
        child.xpath('.//@xlink:href').first.value.to_s
      end
    end

		def to_json
			{ data: output }.to_json
		end

		def output
			@output ||= []
		end
	end

	# GetObservation just focus on two things:
	# 		filter conditions into hash
	# 		send the conditions to specific @request
	class GetObservation

		def initialize(args={})
			@request = args[:request]
			@xml = ObservationRequest.dup
			@request_body = nil
			@tp = []
			@body = ""
		end

		# Without preset Conditions is Okay
		def send(body=nil, &block)
			raise RuntimeError, 'Need to set request' if @request.nil?
			@body = condition.transform @xml if body.nil?
			@request.post(@body, &block) if block_given?
		end

		def body(body=nil)
			@body = body
		end

		# filter() =>  no argument to return @condtion
		# filter({:condition => "value"}) =>  extend @condition
		def filter(custom={})
			raise ArgumentError, 'Filters need to be hash' unless custom.is_a? Hash
			return condition.to_s if custom == {}
			condition.merge! custom
			# p custom
			self
		end

		def inspect
			"<GetObservation 0x#{self.__id__} @condition= #{condition}>"
		end

		def condition
			@condition ||= Factory.new()
		end

		def offering=(list)
			filter({offering: list})
		end

		def procedure=(list)
			filter({procedure: list})
		end

		def observedProperty=(list)
			filter({observedProperty: list})
		end

		def randomID
			tp = "tp_" + rand(100000000).to_s
			(unique? tp) ? tp : randomID
		end

		def unique?(tp)
			not @tp.include? tp
		end

		def temporalFilter=(id=randomID, range)
			@tp << randomID
			filter({ temporalFilter: {
						during: {
				 			valueReference: "phenomenonTime",
				 			timePeriod: { attributes: { id: id }, range: range } }
					  	}
		  			})
		end

	end

end