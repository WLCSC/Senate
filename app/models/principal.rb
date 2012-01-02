class Principal < ActiveRecord::Base
  has_many :permissions
  belongs_to :securable, :polymorphic => true, :foreign_key => 'foreign_id'	
  has_many :chambers, :through => :permissions
  
  def name
	"#{self.securable_type.to_s[0]}/#{securable_name}"
  end
  
  def securable
	begin
	self.securable_type.constantize.find(securable_id)
	rescue 
	nil
	end
  end	
  
  def securable_name
	self.securable ? self.securable.name : nil
  end
  
  def secures? obj
	if self.securable_type == "User"
		self.securable == obj
	elsif self.securable_type == "Group"
		self.securable.users.include? obj
	end
  end
  
  def users
	if self.securable_type == "User"
		[self.securable]
	elsif self.securable_type == "Group"
		self.securable.users
	end
  end
  
  def permission_for(chamber)
	if self.chambers.include? chamber
		chamber.authoritate(self)
	else
		nil
	end
  end
  
  def group
	if self.securable_type == "User"
		self.securable.group
	elsif self.securable_type == "Group"
		self.securable
	end
  end
end
