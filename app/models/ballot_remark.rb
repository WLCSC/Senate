class BallotRemark < ActiveRecord::Base
	belongs_to :user
	belongs_to :ballot
end
