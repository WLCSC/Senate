class Ballot < ActiveRecord::Base
	acts_as_taggable
	belongs_to :chamber
	belongs_to :user
	has_many :ballot_remarks, :dependent => :destroy
	has_many :permissions, :as => :securable, :dependent => :destroy
	attr_accessor :options_raw
	before_create :set_options
	serialize :options, Hash

	def display
		self.title
	end

	def set_options
		x = {}
		i = 0
		self.options_raw.split("\n").each do |l|
			i += 1
			x[i] = l.strip	
		end
		self.options = x	
	end

	def secures user
		x = nil
		self.permissions.sort{|a,b| b.priority <=> a.priority}.each do |p|
			if (p.authorizes? user)
				x = p
			else
			end
		end
		if x
			return x
		else
			y = self.chamber.secures user
			if y
				return y
			else
				return nil
			end
		end
	end

	def secures_without user, skip
		self.permissions.sort{|a,b| a.priority <=> b.priority}.each do |p|
			return p if p.authorizes? user && p != skip
		end
		self.chamber.secures? user
	end

	def users
		(self.principals + self.chamber.principals).map {|x| x.users}.flatten.uniq
	end

	def can? user, right
		p = secures(user)
		r = nil
		if p
			case right
			when :read
				r=p.read
			when :write
				r=p.write
			when :execute, :admin
				r=p.execute
			end
		else
			r=false
			return '*' if user.admin?
		end
		r
	end

	def permissions
		Permission.where(:securable_type => "Ballot").where(:securable_id => self.id)
	end

	def superparent
		self
	end

	def voted? user
		if self.ballot_remarks.where(:user_id => user.id)
			self.ballot_remarks.where(:user_id => user.id).first
		else
			false
		end
	end
end
