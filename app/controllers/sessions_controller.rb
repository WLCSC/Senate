require 'auth.rb'

class SessionsController < ApplicationController
  def new
  end
  
  def create
	if params[:username].match /@/
		puts "Local Login"
		user = User.find_by_email(params[:username])
		if user && user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
			session[:user_id] = user.id
			flash[:notice] = "Logged in!"
			redirect_to '/'
		else
			flash[:alert] = "Invalid local login."
			render 'new'
		end
	else
		puts "LDAP Login"
		if ldap_login(params[:username], params[:password])
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
			flash[:alert] = "Invalid LDAP login."
			render 'new'
		end
	end
  end
  
  def destroy
	session[:user_id] = nil  
	redirect_to root_url, :notice => "Logged out!"  
  end
  
  def index
	redirect_to root_url
  end
  
  def override
	session[:override] = params[:override]
	redirect_to root_url
  end
  
  def cancel_override
	session[:override] = nil
	redirect_to root_url
  end

end
