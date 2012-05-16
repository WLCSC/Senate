require 'simple_ldap_authenticator.rb'

SimpleLdapAuthenticator.servers = [APP_CONFIG[:ldap_domain_controller]]
SimpleLdapAuthenticator.logger = Rails.logger
SimpleLdapAuthenticator.use_ssl = true

def ldap_login user,pass
	#r = Logger.new('auth.txt')
	#r.info("Testing user #{user}")
	if l = SimpleLdapAuthenticator.valid?(user,pass)
		#r.info("Validated user #{user}")
		l
	else
		#r.info("Denied user #{user}")
		raise "Denied!"
		false
	end
end

def ldap_populate user, pass
	if l = SimpleLdapAuthenticator.valid?(user,pass)[0]
		u = User.new
		u.username = user
		u.name = l['givenname'][0].to_s + " " + l['sn'][0].to_s
		u.administrator = true if(l[:memberof].include? APP_CONFIG[:ldap_domain_administrator_ou])
		
		Group.all.each do |group|
			group.users << u if(l[group.auth_attribute.to_sym].include? group.auth_value)
		end
		u.save
		u
	else
		false
	end
end

def ldap_search user
	if l = SimpleLdapAuthenticator.search(user)
		l
	else
		nil
	end
end

def ldap_regroup user, pass
	if l = SimpleLdapAuthenticator.valid?(user,pass)[0]
		u = User.new
		
		Group.all.each do |group|
			group.users << u if(l[group.auth_attribute.to_sym].include? group.auth_value)
		end
		u.save
		u
	else
		false
	end
end

