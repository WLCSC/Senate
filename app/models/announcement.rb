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
			return '*' if user.admin?
			r=false
		end
		r
	end
end
