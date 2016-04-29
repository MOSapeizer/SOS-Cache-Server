class HashMerge < Hash
	def initialize(origin, custom)
		@dough = origin
		@materials = custom
	end
	
	def baked!
		merge @dough, @materials
	end

	def merge(dough, materials)
		mergeForHash(dough, materials) if dough.respond_to? :merge!
		dough + materials if not dough.respond_to? :merge!
	end

	protected

	def mergeForHash(dough, material)
		dough.merge! (material) do |key, dough, material|
			dough, material = setify dough, material
			next categorized dough, material
		end
	end

	def categorized(dough, material)
		hash_dough, string_dough = split dough
		material_hash, material_string = split material

		hash = combineHash(hash_dough, material_hash)
		summary = string_dough + material_string + hash
	end

	def combineHash(*parts)
		(combine parts[0], parts[1]).to_set
	end

	def combine(dough, materials)
		materials.each { |part| blend dough, part }
		dough
	end

	def blend(dough, part)
		flag = true
		dough.each do |hash|
			if hash.keys == part.keys
				flag = false
				next recursiveMerge(hash, part)
			end
		end
		dough << part if flag
	end

	def recursiveMerge(origin, custom)
		origin.merge! custom do |key, origin, custom|
			merge origin, custom
		end
	end

	def setify(*list)
		list.map do |obj|
			obj = [obj].to_set if not obj.is_a? Set
			obj
		end
	end

	def split(set)
		hash = set.to_a.keep_if { |value| value.is_a? Hash  }
		string = set - hash
		return hash, string.to_set
	end
end