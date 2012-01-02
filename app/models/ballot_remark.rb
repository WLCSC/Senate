class BallotRemark < ActiveRecord::Base
  attr_accessible :user_id, :ballot_id, :remark
  
  belongs_to :user
  belongs_to :ballot
end
