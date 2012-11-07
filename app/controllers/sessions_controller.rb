require 'auth.rb'

class SessionsController < ApplicationController
	def new
		if current_user
			redirect_to params[:return] || '/'
		end
	end

	def create
		lgi = ldap_login(params[:username], params[:password])
		if lgi && lgi.length > 0
			user = User.find_by_username(params[:username])
			user = ldap_populate(params[:username], params[:password], user)
			session[:user_id] = user.id
			flash[:notice] = "Logged in!"
			redirect_to params[:return] || '/'
		else
			flash[:alert] = "Invalid login."
			redirect_to '/sessions/new'
		end
	end

	def destroy
		session[:user_id] = nil  
		redirect_to root_url, :notice => "Logged out!"  
	end
end
