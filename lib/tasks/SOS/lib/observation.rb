require 'json'

module SOSHelper

  class GetInformRequest
    def initialize(request, xml)
      @request = request
      @xml = xml
      @body = ''
    end

    # Without preset Conditions is Okay
    def send(body=nil, &block)
      raise RuntimeError, 'Need to set request' if @request.nil?
      @body = condition.transform @xml if body.nil?
      @request.post(@body, &block) if block_given?
    end

    def body(body)
      @body = body
    end

    # filter() =>  no argument to return @condtion
    # filter({:condition => "value"}) =>  extend @condition
    def filter(custom={})
      raise ArgumentError, 'Filters need to be hash' unless custom.is_a? Hash
      return condition.to_s if custom == {}
      condition.merge! custom
      self
    end

    def inspect
      "<GetInformRequest 0x#{self.__id__} @condition= #{condition}>"
    end

    def condition
      @condition ||= Factory.new
    end

  end

  class FeatureOfInterest
    def initialize(str)
      @xml = Nokogiri::XML(str)
    end

    def parse
      data_list = @xml.xpath('//sos:featureMember')
      @output = data_list.map do |data|
        position = check_value(data.xpath('.//gml:pos', 'gml' => 'http://www.opengis.net/gml/3.2'))
        next { longitude: position[0], latitude: position[1]}
      end
    end

    def check_value(tag)
      tag.text.split(' ')
    end

    def to_json
      { data: output }.to_json
    end

    def output
      @output ||= []
    end
  end

  class GetFeatureOfInterest < GetInformRequest
    def initialize(args={})
      super(args[:request], FeatureRequest.dup)
      @body = ''
    end

    def inspect
      "<GetFeatureOfInterest 0x#{self.__id__} @condition= #{condition}>"
    end

    def feature=(name)
      filter({featureOfInterest: name})
    end

  end

	class Observation
		def initialize(str)
			@xml = Nokogiri::XML(str)
		end

		def parse
      data_list = @xml.xpath('//sos:observationData')
			@output = data_list.map do |data|
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
	class GetObservation < GetInformRequest

		def initialize(args={})
      super(args[:request], ObservationRequest.dup)
			@tp = []
			@body = ''
    end

		def inspect
			"<GetObservation 0x#{self.__id__} @condition= #{condition}>"
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
			tp = 'tp_' + rand(100000000).to_s
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