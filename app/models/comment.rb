class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :ancestry, :commentable_id, :commentable_type
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable
  
  def commentable
	self.commentable_type.constantize.find(commentable_id)
  end
  
  def commentable= c,i=nil
	if c.is_a? Array
		self.commentable_type = c[0]
		self.commentable_id = c[1]
	elsif i==nil 
		self.commentable_type = c.class.to_s
		self.commentable_id = c.id
	else
		self.commentable_type = c
		self.commentable_id = i
	end
  end
  
  def count_children
	t = 1
	self.comments.each do |c|
		t += c.count_children
	end
	t
  end
  
  def chamber
	if commentable.chamber
		commentable.chamber
	else
		commentable.commentable.chamber
	end
  end
end
