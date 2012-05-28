class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
	@current_user
  end

  def current_user
	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def check_for_user
    redirect_to '/sessions/new' unless current_user
  end
  
  def check_for_admin
    redirect_to '/home/index' unless current_user && current_user.admin?
  end

  def find_chamber
	unless @chamber
		if params[:chamber_id]
			@chamber = Chamber.find(params[:chamber_id])
		end
	end
  end
end
