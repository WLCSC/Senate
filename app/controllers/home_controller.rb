class HomeController < ApplicationController
  def index
	@news = NewsItem.all 
	current_user.permissions.each{|c| @news += c.chamber.announcements} if current_user
	@news.sort!{|a,b| b.created_at <=> a.created_at}
	@news = @news.first(3)
  end

end
