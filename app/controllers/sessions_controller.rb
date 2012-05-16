require 'auth.rb'

class SessionsController < ApplicationController
  def new
  end
  
  def create
	lgi = ldap_login(params[:username], params[:password])
	if lgi && lgi.length > 0
		user = User.find_by_username(params[:username])
		if user
			session[:user_id] = user.id
		else
			user = ldap_populate(params[:username], params[:password])
			session[:user_id] = user.id
		end
		flash[:notice] = "Logged in!"
			redirect_to '/'
	else
		flash[:alert] = "Invalid login."
		redirect_to '/'
	end
  end
  
  def destroy
	session[:user_id] = nil  
	redirect_to root_url, :notice => "Logged out!"  
  end
end
