class Proposal < ActiveRecord::Base
  attr_accessible :name, :content, :creator_id, :chamber_id, :closed
  
  has_many :comments, :as => :commentable
  belongs_to :creator, :class_name => "User"
  belongs_to :chamber
  has_many :remarks, :class_name => "ProposalRemark"
  
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
	if self.remarks.where(:user_id => user.id)
		self.remarks.where(:user_id => user.id).first
	else
		false
	end
  end
end

