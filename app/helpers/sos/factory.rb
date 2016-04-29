require_relative 'boss.rb'
require_relative 'hashMerge.rb'
require 'set'

# a = Factory.new
# a.merge!({offering: "1"})
# a.merge!({offering: "2"})
# a.merge!({offering: "3"})
# p a.merge!({offering: "4"})
# p a.transform SOSHelper::ObservationRequest.dup


# Factory focus on three things:
#   1. uniform the hash
#   2. extend condition
#   3. transform the condition
class Factory < Hash
	def initialize(custom={})
		@condition = uniform custom
	end

	# uniform any hash
	def uniform(custom)
		custom.each do |k, v| 
			next if v.is_a? Set
			next (custom[k] = uniform v) if v.is_a? Hash
			next (custom[k] = magic v) if v.is_a? Array
			custom[k] = [v].to_set unless v.is_a? Array
			custom[k] = custom[k].to_set unless v.is_a? Set
		end		
		# p "extend filter with: " + custom.to_s
		custom
	end

	# notify boss we have new tasks
	# and send our base to him
	def transform(base, obj=nil)
		conditions = obj || condition
		projects = checkOf conditions 
		jobs = SOSHelper::Boss.new base, projects
		achievements = jobs.assign

		achievements.to_xml
	end

	def magic(paragraph)
		paragraph.each { |too_detail| DontWantToRefactorThisBecauseItIs too_detail }.to_set
	end

	def DontWantToRefactorThisBecauseItIs(too_detail)
		uniform too_detail if not too_detail.is_a? String
	end

	def checkOf(obj)
		return condition.dup if obj.respond_to? :condition
		uniform(obj)
	end

	def merge! custom
		uniform custom
		dough = HashMerge.new(self.condition, custom)
		dough.baked!
		self
	end

	def to_s
		@condition
	end

	alias :condition :to_s
end 
