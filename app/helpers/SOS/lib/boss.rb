require_relative 'company.rb'

module SOSHelper

	# Boss Assign the tasks
	# Assign class check each task is done by a correct employee
	# Assign workflow:
	# 	1. recognize key as a employee
	# 	2. assign tasks to him
	# 	3. Boss summerize the base and results

	class Boss
		def initialize(base, projects)
			@base = base
			@projects = projects
		end

		def assign
      @tag = Tag.new
      @tag.offering @projects[:offering].to_a
      @tag.property @projects[:observedProperty].to_a
			temporal = @projects[:temporalFilter][:during][:timePeriod]
      @tag.temporal temporal[:attributes][:id].to_a[0], temporal[:range].to_a[0]

      summarize @base, @tag.output

      @base
		end

		def summarize(base=nil, bonus="")
			base.root.add_child bonus
		end

	end
end

# a =  SOSHelper::Boss.new(:procedure, ["1", "2"])
# p a.done