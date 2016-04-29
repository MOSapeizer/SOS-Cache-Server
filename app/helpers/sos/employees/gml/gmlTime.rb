require 'time'


class Time
	def toTimeZone(time=nil)
		return time.utc.iso8601 unless time.nil?
		self.utc.iso8601
	end
end

class GMLTime < Time
	def initialize(time)
		@time = toDateTime time
		super *(@time.to_a[0..5].reverse)
	end

	def toTimeZone(time=nil)
		return time.utc.iso8601 unless time.nil?
		@time.utc.iso8601
	end

	def toDateTime(time=nil)
		return Time.parse(time).localtime unless time.nil?
		Time.parse(@time).localtime
	end
end