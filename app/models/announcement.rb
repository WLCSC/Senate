require 'commentable.rb'

class Announcement < ActiveRecord::Base
	include CommentableModel
	acts_as_taggable
	belongs_to :user
	belongs_to :chamber
	has_many :comments, :as => :commentable, :dependent => :delete_all
	
end
