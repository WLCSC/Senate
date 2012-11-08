require 'commentable.rb'

class Announcement < ActiveRecord::Base
	include CommentableModel
	acts_as_taggable
	belongs_to :user
	belongs_to :chamber
	has_many :comments, :as => :commentable, :dependent => :delete_all

	def superparent
		self
	end
def secures user
		x = nil
		self.chamber.permissions.sort{|a,b| b.priority <=> a.priority}.each do |p|
			if (p.authorizes? user)
				puts "Ballot##{self.id}: [#{p.to_qs}] secures #{user.name}"
				x = p
			else
				puts "Ballot##{self.id}: [#{p.to_qs}] does not secure #{user.name}"
			end
		end
		if x
			puts "Ballot##{self.id}: Directly secures #{user.name} with [#{x.to_qs}]"
			return x
		else
			y = self.chamber.secures user
			if y
				puts "Ballot##{self.id}: Indirectly secures #{user.name} with [#{y.to_qs}]"
				return y
			else
				puts "Ballot##{self.id}: Does not secure #{user.name}"
				return nil
			end
		end
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
		puts "Ballot##{self.id}: can #{user.name} #{right.to_s}: #{r}"
		r
	end
end
