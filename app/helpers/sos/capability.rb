require 'nokogiri'
require_relative 'employees/sos/contents.rb'

module SOSHelper
	class Capability
		def initialize(args={})
			@root = args[:root].dup
		end

		def contents
			contents = @root.xpath("//sos:Contents")
			Contents.new(contents)
		end

		def filterCapabilities
			
		end

		def extension
			
		end

	end

	class GetCapability

		attr_reader :capabilities
		def initialize(args={})
			@request = args[:request]
			@url = args[:url]
			@query = {}
			@capabilities = nil
		end

		def send(query={})
			query[:service] = query[:service] || "SOS"
			query[:request] = query[:request] || "GetCapabilities"
			query[:version] = query[:version] || "2.0.0"
			@capabilities = request.get(query) do |str| xml = Nokogiri::XML(str) 
													Capability.new(root: xml)
											   end
		end

		private

		def dig(operation, type="Value")
			@capabilities.xpath("//ows:Operation[@name='GetObservation']//ows:Parameter[@name='#{operation}']//ows:#{type}")
		end

		def request
			@request ||= XmlRequest.new(@url)
		end

		def check(relics)
			backpack = {}

			relics.each do |relic|
				level = checkLevelOf relic

				backpack[ relic.to_sym ] = adventure level, relic
			end

			backpack
		end

		def adventure(level, relic)
			if level == "normal"
				(dig relic).map { |treasure| normal treasure }
			else
				(dig relic, "Range").map { |treasure| complex treasure}
			end
		end

		def checkLevelOf(condition)
			!(condition.include? "Filter") ? "normal" : "complex"
		end

		def normal(tag)
			tag.text
		end

		def complex(tag)
			[tag.xpath(".//ows:MinimumValue").text, tag.xpath(".//ows:MaximumValue").text]
		end
	end
end