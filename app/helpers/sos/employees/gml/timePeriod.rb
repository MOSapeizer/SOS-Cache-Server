class TimePeriod < Complicated

	def do(tasks)
		task = tasks[0]
		if typeOf task, is: Hash
			checkAttributesIn task
			tag task[:range].to_a[0]
		elsif typeOf task, is: String
			tag task.to_a[0]
		end
	end

	def custom(value)
		begin_time, end_time = value.split " "
		position("begin", begin_time) + position("end", end_time)
	end

	def position(where, time)
		"<gml:#{where}Position>#{time}</gml:#{where}Position>"
	end

	def tag_name
		class_name
	end

	def namespace
		"gml:"
	end
end