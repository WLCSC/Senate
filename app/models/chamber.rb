class Chamber < ActiveRecord::Base
  attr_accessible :name, :about
  
  has_many :permissions
  has_many :principals, :through => :permissions
  has_many :proposals
  has_many :ballots
  has_many :announcements
  has_many :boards
  has_many :titles
  
  def authoritate user
	self.permissions.sort{|a,b| a.priority <=> b.priority}.each do |p|
		return p if p.secures? user
	end
	nil
  end
  
  def authoritate_without user, skip
	self.permissions.sort{|a,b| a.priority <=> b.priority}.each do |p|
		return p if p.secures? user && p != skip.permission
	end
	nil
  end
  
  def users
	self.principals.map {|x| x.users}.flatten.uniq
  end
  
  def titles_for user
	r = []
	self.titles.each do |title|
		r << title if title.users.include? user
	end
	r
  end
  
  def admins
	r=[]
	users.each do |user|
		r << user if authoritate(user).can? :administrat
	end
	r
  end
  
  def announce(message,user)
	a = Announcement.new
	a.chamber = self
	a.user_id = user.id
	a.title = "System Message"
	a.content = message
	a.save
  end
end
