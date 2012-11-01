require 'commentable.rb'

class Board < ActiveRecord::Base
	include CommentableModel
	acts_as_taggable
	belongs_to :chamber
	has_many :comments, :as => :commentable, :dependent => :destroy
	has_many :permissions, :as => :securable, :dependent => :destroy

	def secures user
		x = nil
		self.permissions.sort{|a,b| b.priority <=> a.priority}.each do |p|
			if (p.authorizes? user)
				puts "Board##{self.id}: [#{p.to_qs}] secures #{user.name}"
				x = p
			else
				puts "Board##{self.id}: [#{p.to_qs}] does not secure #{user.name}"
			end
		end
		if x
			puts "Board##{self.id}: Directly secures #{user.name} with [#{x.to_qs}]"
			return x
		else
			y = self.chamber.secures user
			if y
				puts "Board##{self.id}: Indirectly secures #{user.name} with [#{y.to_qs}]"
				return y
			else
				puts "Board##{self.id}: Does not secure #{user.name}"
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
			when :execute
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
