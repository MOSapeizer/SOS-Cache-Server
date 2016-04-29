class People
	def initialize()
		@attributes = ""
	end

	def do(tasks)

	end

	def typeOf(task, args={})
		raise ArgumentError "Set check type" if args == {}
		type = args[:is] || args[:is_not]
		return task.class == type if not args[:is].nil?
		return task.class != type if not args[:is_not].nil?
	end

	def inspect
		self.to_s
	end

	def inject(task)
		task if typeOf task, is: String
	end

	def tag(value=nil)
		"<#{namespace}#{tag_name}>#{value.to_s}</#{namespace}#{tag_name}> "
	end

	def tag_name
		uncapitalize self.class.to_s
	end

	def uncapitalize(name)
		name = name.dup
		name[0] = name[0].downcase;
		name
	end

	def capitalize(name)
		name = name.dup
		name[0] = name[0].upcase;
		name
	end

	def attributes(attrs)
		p attrs
		attrs.each { |k, v| @attributes += " #{namespace}" + k.to_s + "=\"" + v.to_a[0] + "\"" }
	end

	def class_name
		self.class.to_s
	end

	def namespace
		nil
	end

end