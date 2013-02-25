require 'commentable.rb'

class Board < ActiveRecord::Base
	include CommentableModel
	acts_as_taggable
	belongs_to :chamber
	has_many :comments, :as => :commentable, :dependent => :destroy
	has_many :permissions, :as => :securable, :dependent => :destroy

	def display
		self.title
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
		end
		puts "Board##{self.id}: can #{user.name} #{right.to_s}: #{r}"
		r
	end

	def permissions
		Permission.where(:securable_type => "Board").where(:securable_id => self.id)
	end

	def superparent
		self
	end
end
