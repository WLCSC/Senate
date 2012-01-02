class Announcement < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :chamber_id
  
  belongs_to :user
  has_many :comments, :as => :commentable
  belongs_to :chamber
  
  def count_children
	t = 1
	self.comments.each do |c|
		t += c.count_children
	end
	t
  end
end
