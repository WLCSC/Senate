class Event < ActiveRecord::Base
	acts_as_taggable
	belongs_to :chamber
	has_many :attendees, :dependent => :destroy
	has_many :users, :through => :attendees
	validates :time, :presence => true
	attr_accessor :timestring

	before_save :fix_time

	def display
		self.title
	end

	def fix_time
		if self.timestring != "" && self.timestring.is_a?(String)
			begin
			self.timestring.match /(\d+)\/(\d+)\/(\d+) (\d+):(\d+)/
			self.time = DateTime.civil($3.to_i, $1.to_i, $2.to_i, $4.to_i, $5.to_i)
			self.time += 4.hours
			rescue
				self.errors.add :base, "Invalid date."
			end
		elsif self.timestring != ""
			
		end

	end

	def past?
		self.time < Time.now
	end

	def old?
		self.time < Time.now
	end
end
