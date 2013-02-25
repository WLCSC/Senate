class Chamber < ActiveRecord::Base
	has_many :boards, :dependent => :destroy
	has_many :titles, :dependent => :destroy
	has_many :announcements, :dependent => :destroy
	has_many :proposals, :dependent => :destroy
	has_many :ballots, :dependent => :destroy
	has_many :events, :dependent => :destroy
	has_many :permissions, :as => :securable, :dependent => :destroy
	has_many :principals, :through => :permissions
	has_many :logs
	belongs_to :assembly

	def display
		self.title
	end

	def parent
		self.assembly
	end

	def path
		buf = parent.path
		buf << " > " << title
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
			return nil
		end
	end

	def secures_without user, skip
		self.permissions.sort{|a,b| a.priority <=> b.priority}.each do |p|
			return p if p.authorizes? user && p != skip
		end
	end

	def users
		self.principals.map {|x| x.users}.flatten.uniq
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
		puts "Chamber##{self.id}: can #{user.name} #{right.to_s}: #{r}"
		r
	end

	def permissions
		Permission.where(:securable_type => "Chamber").where(:securable_id => self.id)
	end

	def admins
		r = []
		permissions.where(:execute => true).all.map{|p| p.principal}.each do |pr|
			r << pr.users 
		end

		r.flatten.uniq
	end

	def titles_for user
		Entitlement.where(:user_id => user.id).where(:title_id => self.title_ids).all.map{|w| w.title}
	end

	def online_users
		users.delete_if{|u| !u.online?}
	end	
end
