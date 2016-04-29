require_relative '../mankind/Complicated.rb'
require_relative '../sos/time.rb'

module SWES
	class Offering < Complicated
		attr_accessor :keys
		def initialize(offering)
			@offering = offering
			@keys = [ :identifier,
					  :procedure,
					  :procedureDescriptionFormats,
					  :observableProperty,
					  :phenomenonTime,
					  :resultTime,
					  :responseFormat ]
		end

		def identifier
			@identifier ||= find("swes:identifier")
		end

		def procedure
			@procedure ||= find("swes:procedure")
		end

		def procedureDescriptionFormats
			@procedureDescriptionFormats ||= 
				findAll("swes:procedureDescriptionFormat")
		end

		def observableProperty
			@observableProperty ||= 
				findAll("swes:observableProperty")
		end

		def observedArea
			@observedArea
		end

		def responseFormat
			@responseFormat ||= 
				findAll "sos:responseFormat"
		end

		def phenomenonTime
			PhenomenonTime.new find("sos:phenomenonTime", false)
		end

		def resultTime
			ResultTime.new find("sos:resultTime", false)
		end

		def find(tag, text=true)
			return @offering.xpath(".//" + tag).text if text
			@offering.xpath(".//" + tag)
		end

		def findAll(tag)
			@offering.xpath(".//" + tag).map { |tag| tag.text }
		end

		def inspect
			id = identifier.ascii_only? ? identifier : "UTF-16"
			"Offering: @id='#{id}'"
		end

		def self.name
			self.new().class.to_s
		end

		def tag_name
			self.class.to_s.split("::")[1]
		end

		def namespace
			"swes:"
		end
	end
end