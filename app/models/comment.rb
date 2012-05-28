require 'commentable.rb'

class Comment < ActiveRecord::Base
	include CommentableModel
	belongs_to :commentable, :polymorphic => true
	belongs_to :user
	has_many :comments, :as => :commentable, :dependent => :destroy
	
	

	def chamber
		if commentable.chamber
			commentable.chamber
		else
			commentable.commentable.chamber
		end
	end

	def superparent
		if commentable.is_a? Comment
			commentable.superparent
		else
			commentable
		end
	end
end
