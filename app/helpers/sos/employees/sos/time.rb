require_relative '../gml/gmlTime.rb'

class SOSTime
	def initialize(time)
		@time = checkTimeType time
	end

	def timeInstant(time)
		time.xpath(".//gml:TimeInstant")
	end

	def timePeriod(time)
		time.xpath(".//gml:TimePeriod")
	end

	def range(beginTime=beginPosition, endTime=endPosition)
		beginTime.toTimeZone + " " + endTime.toTimeZone
	end

	def timePosition
		@instant ||= gmlTime find("gml:timePosition")
	end

	def beginPosition
		@begin ||= gmlTime find("gml:beginPosition")
	end

	def endPosition
		
		@end ||= gmlTime find("gml:endPosition")
	end

	def gmlTime(time)
		GMLTime.new time unless time.empty?
	end

	def find(tag)
		@time.xpath(".//" + tag).text
	end

	def checkTimeType(time)
		type = timeInstant time
		type = timePeriod time if type.empty?
	end

	def inspect
		time = timePosition.nil? ? "@begin: #{beginPosition}, @end: #{endPosition}" : "@intant: #{@instant}"
		"PhenomenonTime: #{time}"
	end
end

class PhenomenonTime < SOSTime
	
end

class ResultTime < SOSTime
	
end