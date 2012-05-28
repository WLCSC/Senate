require 'commentable.rb'

class Proposal < ActiveRecord::Base
	include CommentableModel
	belongs_to :chamber
	belongs_to :user
	has_many :proposal_remarks, :dependent => :destroy
	has_many :comments, :as => :commentable, :dependent => :destroy

	def secures user
		x = nil
		self.permissions.sort{|a,b| b.priority <=> a.priority}.each do |p|
			if (p.authorizes? user)
				puts "Proposal##{self.id}: [#{p.to_qs}] secures #{user.name}"
				x = p
			else
				puts "Proposal##{self.id}: [#{p.to_qs}] does not secure #{user.name}"
			end
		end
		if x
			puts "Proposal##{self.id}: Directly secures #{user.name} with [#{x.to_qs}]"
			return x
		else
			y = self.chamber.secures user
			if y
				puts "Proposal##{self.id}: Indirectly secures #{user.name} with [#{y.to_qs}]"
				return y
			else
				puts "Proposal##{self.id}: Does not secure #{user.name}"
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
		puts "Proposal##{self.id}: can #{user.name} #{right.to_s}: #{r}"
		r
	end

	def permissions
		Permission.where(:securable_type => "Proposal").where(:securable_id => self.id)
	end

	def ratio
		positive.to_f / negative.to_f
	end

	def positive
		ProposalRemark.where(:proposal_id => self.id, :remark => 1).count
	end

	def negative
		ProposalRemark.where(:proposal_id => self.id, :remark => 0).count
	end

	def voted? user
		if self.proposal_remarks.where(:user_id => user.id)
			self.proposal_remarks.where(:user_id => user.id).first
		else
			false
		end
	end

	def superparent
		self
	end
end
