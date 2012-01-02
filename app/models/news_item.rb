class NewsItem < ActiveRecord::Base
  attr_accessible :title, :content, :user_id
  
  belongs_to :user
end
