 task :regroup => :environment do
	User.all.each do |user|
		Group.all.each do |group|
			group.users << user if (l[group.auth_attribute.to_sym].include? group.auth_value)
		end
		user.save
	end	
 end
