desc 'Add an initial internal user'
task :adduser => :environment do
        User.create(:username => 'admin', :password => 'admin', :name => "Administrator", :email => 'admin@nowhere.com', :administrator => true)
end
