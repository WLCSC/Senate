require 'bcrypt'

class User < ActiveRecord::Base
	has_many :memberships
	has_many :groups, :through => :memberships
	has_one :principal, :as => :authorizable
	has_many :permissions, :through => :principal
	has_many :atendees
	has_many :events, :through => :attendees
	has_many :news_items
	has_many :announcements
	has_many :comments
	has_many :proposal_remarks
	has_many :proposals
	has_many :ballots
	has_many :ballot_remarks
	has_many :entitlements
	has_many :titles, :through => :entitlements
	has_many :logs
	attr_accessor :password
	validates :username, :presence => true
	validates :password, :confirmation => true

	before_save :encrypt_password
	before_create :create_principal

	def display
		self.name
	end

	def create_principal
		self.build_principal.save
	end

	def encrypt_password
		if password
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end


	def fqn
		"wlcsc\\#{self.username}"
	end

	def admin?
		administrator
	end

	def belongs_to? group
		group.users.include? self
	end

	def member_of? group
		group.users.include? self
	end

	def titleize(chamber = nil)
		r = self.name
		titles = ""
		if chamber
			titles += chamber.titles_for(self).map{|t| t.title }.join(", ")
		else
			t = []
			Chamber.all.each do |c|
				t << c.titles_for(self).map{|t| t.title }.join(", ") 
			end
			titles += t.join(', ')
		end
		r += ", " + titles if titles != ""
		
		if r.length > 60
			r = r[0...57] + "..."	
		end
		r
	end

	def chambers
		chambers = []
		Chamber.all.each do |c|
			chambers << c if c.secures self
		end
		chambers
	end

	def online?
		updated_at > 5.minutes.ago
	end	
end
