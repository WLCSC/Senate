class Group < ActiveRecord::Base
	has_many :memberships, :dependent => :destroy
	has_many :users, :through => :memberships
	has_one :principal, :as => :authorizable, :dependent => :destroy
	has_many :permissions, :through => :principal
	after_create :c_principal

	def display
		self.name
	end

	def all_principals
		[self.principal] + self.users.map{|u| u.principal}
	end

	private
	def c_principal
		p = self.build_principal
		p.save
	end
end
