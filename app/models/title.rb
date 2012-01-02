class Title < ActiveRecord::Base
  attr_accessible :text, :about, :chamber_id, :user_tokens
  attr_reader :user_tokens
  
  belongs_to :chamber
  has_and_belongs_to_many :users
  
  def user_tokens= ids
	self.user_ids = ids.split(',')
  end
  
  def user_tokens
	r = ''
	self.users.each do |u|
		r << u.id.to_s << ','
	end
	r
  end
end
