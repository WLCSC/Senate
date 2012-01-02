class Permission < ActiveRecord::Base
  attr_accessible :name, :priority, :readable, :commentable, :proposable, :remarkable, :votable, :chamber_id, :principal_id, :administratable
  belongs_to :chamber
  belongs_to :principal
  
  def secures? user
	self.principal.secures? user
  end
  
  def can right
	right = right.to_s
	case right
		when /read/
			self.readable
		when /comment/
			self.commentable
		when /propos/
			self.proposable
		when /vot/
			self.votable
		when /admin/
			self.administratable
		when /remark/
			self.remarkable
		else
			nil
	end
  end
  
  def can? right
	can right
  end
end
