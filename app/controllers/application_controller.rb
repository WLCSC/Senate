class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_chamber_id
  
  private
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
	if @current_user && session[:override]
		@current_user.privilege = session[:override]
	end
	@current_user
  end
  
  def set_chamber_id
	if params[:chamber_id]
		@chamber = Chamber.find(params[:chamber_id])
	end	
  end
end
