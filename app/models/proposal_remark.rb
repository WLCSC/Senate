class ProposalRemark < ActiveRecord::Base
  attr_accessible :user_id, :proposal_id, :remark
  
  validates_uniqueness_of :user_id, :scope => :proposal_id
  
  belongs_to :user
  belongs_to :proposal
end

