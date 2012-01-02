class Ballot < ActiveRecord::Base
  attr_accessible :name, :content, :options, :creator_id, :closed, :options_raw, :chamber_id, :anonymous
  attr_accessor :options_raw
  
  has_many :remarks, :class_name => "BallotRemark"
  belongs_to :creator, :class_name => "User"
  belongs_to :chamber
  
  def voted? user
	if self.remarks.where(:user_id => user.id)
		self.remarks.where(:user_id => user.id).first
	else
		false
	end
  end
end
