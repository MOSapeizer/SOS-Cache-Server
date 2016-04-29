require_relative 'people.rb'
require 'set'

#   => '{:filter=>
#   		{:During=>#<Set: {"1", "2", 
#   			{:fuck=>#<Set: {"test"}>}}>}, 
#   	 :offering=>#<Set: {"1", "2", "3", "4"}>}'
class Complicated < People
	def do(tasks)
		result = plan(tasks).map do |task|
				 	if typeOf task, is: Hash
				 		checkAttributesIn task
						next assigns task
					end
					next self.do task if typeOf task, is: Array
					next task if typeOf task, is: String
				 end
		report result
	end

	def checkAttributesIn(task)
		unless task[:attributes].nil?
 			attributes task[:attributes] 
 			task.delete :attributes
 		end
	end

	def report(result)
		result.map { |task| tag task }.join " "
	end

	def plan(task)
		return task.to_a if typeOf task, is: Set
		return task if typeOf task, is: Array
		[task]
	end

	def assigns(task)
		report = ""
		task.each do |subordinate, subtask|
			subordinate = eval( capitalize(subordinate.to_s) + ".new")
			report += subordinate.do plan(subtask)
		end
		report
	end

	def tag(value=nil, attrs={})
		"<#{namespace}#{tag_name}#{@attributes}> #{custom value}</#{namespace}#{tag_name}> "
	end

	def custom(value)
		value.to_s
	end

end