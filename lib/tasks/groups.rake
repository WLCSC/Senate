 task :regroup => :environment do
	require 'auth.rb'
	User.all.each do |user|
		l = ldap_search user.username
		puts "Checking #{l[:cn]} - #{l[:memberof].length}"
		Group.all.each do |group|
			if (l[group.auth_attribute.to_sym].include? group.auth_value)
				group.users << user
				puts "Added to #{group.name}"
			end
		end
		user.save
	end	
 end
