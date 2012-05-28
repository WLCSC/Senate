class Principal < ActiveRecord::Base
	has_many :permissions, :dependent => :destroy
	belongs_to :authorizable, :polymorphic => :true

	def name
		"#{self.authorizable_type.to_s[0]}/#{authorizable_name}"
	end

	def nice_name
		name
	end

	def authorizable
		begin
			self.authorizable_type.constantize.find(authorizable_id)
		rescue
			nil
		end
	end

	def authorizable_name
		self.authorizable ? self.authorizable.name : nil
	end

	def authorizes? obj
		if self.authorizable_type == "User"
			self.authorizable == obj
		elsif self.authorizable_type == "Group"
			self.authorizable.users.include? obj
		end
	end

	def users
		if self.authorizable_type == "User"
			[self.authorizable]
		else
			self.authorizable.users
		end
	end

	def groups
		if self.authorizable_type == "Group"
			[self.authorizable]
		else
			self.authorizable.groups
		end
	end

	def ids
		if self.authorizable_type == "User"
			[self.authorizable.id]
		else
			self.authorizable.user_ids
		end
	end
end
