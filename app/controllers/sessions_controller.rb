require 'auth.rb'

class SessionsController < ApplicationController
	def show
		redirect_to root_path
	end
	def new
		if current_user
			redirect_to params[:return] || root_path
		end
	end

	def create
		params[:username].downcase!
		user = User.where(:username => params[:username]).first
		n = nil
		if APP_CONFIG[:auth_ldap] && user.password_hash == nil
			puts "LDAP"
			lgi = ldap_login(params[:username], params[:password])
			if lgi && lgi.length > 0
				user = ldap_populate(params[:username], params[:password], user)
				session[:user_id] = user.id
				n = "Logged in!"
				puts "OK"
			else
				n = "Invalid login."
				puts "ERROR"
			end
		end
		if APP_CONFIG[:auth_local] && user && user.password_hash != nil
			puts "local"
			if user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
				session[:user_id] = user.id
				n = "Logged in!"
				puts "OK"
			else
				n = "Invalid local login."
				puts "ERROR"
			end
		end
		redirect_to root_path, :notice => n
	end

	def destroy
		session[:user_id] = nil  
		redirect_to root_url, :notice => "Logged out!"  
	end
end
