class Assembly < ActiveRecord::Base
	belongs_to :parent, :class_name => "Assembly"
	has_many :chambers
	has_many :assemblies, :foreign_key => 'parent_id'

	def display
		self.name
	end

	def ancestors
		arr = []
		x = self
		while x
			arr << x
			x = x.parent
		end
		arr.reverse
	end

	def path
		buf = ""
		anc = ancestors
		buf << anc.delete_at(0).name
		anc.each do |a|
			buf << " > " + a.name 
		end
		buf
	end
end
