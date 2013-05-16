class NewsItem < ActiveRecord::Base
	belongs_to :user

    def can? *args
        true
    end
end
