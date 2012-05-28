class HomeController < ApplicationController
  def index
	  redirect_to '/sessions/new' unless current_user

	  @news = NewsItem.all 
	current_user.chambers.each{|c| @news += c.announcements} if current_user
	@news.sort!{|a,b| b.created_at <=> a.created_at}
	@news = @news.first(3)
  end
end
