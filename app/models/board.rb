class Board < ActiveRecord::Base
  attr_accessible :name, :about, :chamber_id
  
  has_many :comments, :as => :commentable
  belongs_to :chamber
end
