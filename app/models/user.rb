class User < ActiveRecord::Base
	attr_accessible :username, :administrator, :email, :password, :password_confirmation, :name
	
	attr_accessor :password
	
	before_save :encrypt_password
	after_create :c_principal
  
	has_and_belongs_to_many :groups
	has_many :comments
	has_many :created_proposals, :class_name => "Proposal"
	has_many :proposal_remarks
	has_many :proposals, :through => :proposal_remarks
	has_many :created_ballots, :class_name => "Ballot"
	has_many :ballot_remarks
	has_many :ballots, :through => :ballot_remarks
	has_many :announcements
	has_many :news_items
	has_and_belongs_to_many :titles
	has_one :principal, :as => :securable
	has_many :permissions, :through => :principal
	
	
	def fqn
		ldap? ? "#{APP_CONFIG[:ldap_domain_login]}\\#{self.username}" : email
	end
	
	def ldap?
		!password.present?
	end
	
	def email
		if ldap?
			"#{self.username}@#{APP_CONFIG[:ldap_domain_email]}"
		else
			self.email
		end
	end
	
	def titleize(chamber = nil)
		r = self.name
		titles = ""
		if chamber
			titles += chamber.titles_for(self).map{|t| t.text }.join(", ")
		else
			t = []
			Chamber.all.each do |c|
				t << c.titles_for(self).map{|t| t.text }.join(", ") 
			end
			titles += t.join(', ')
		end
		r += ", " + titles if titles != ""
		
		r
	end
	
	def belongs_to? group
		group.users.include? self
	end
	
	def chambers
		chambers = []
		Chamber.all.each do |c|
			chambers << c if c.authoritate self
		end
		chambers
	end
	
	private
	
	def c_principal
		p = self.build_principal
		p.save
	end
	
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
