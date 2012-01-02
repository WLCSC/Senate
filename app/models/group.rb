class Group < ActiveRecord::Base
  attr_accessible :name, :about, :auth_attribute, :auth_value, :user_tokens
  attr_reader :user_tokens
  after_create :c_principal
  
  has_and_belongs_to_many :users
  has_one :principal, :as => :securable
  
  def all_principals
	[self.principal] + self.users.map{|u| u.principal}
  end
  
  def user_tokens= ids
	self.user_ids = ids.split(',')
  end
  
  def user_tokens
	r = ''
	self.users.each do |u|
		r << u.id.to_s << ','
	end
	r
  end
  
  private 
  
  def c_principal
		p = self.build_principal
		p.save
	end
	
  
end
