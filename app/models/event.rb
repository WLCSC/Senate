class Event < ActiveRecord::Base
	acts_as_taggable
	belongs_to :chamber
	has_many :attendees, :dependent => :destroy
	has_many :users, :through => :attendees
	attr_accessor :timestring

	before_save :fix_time

	def fix_time
		if self.timestring != "" && self.timestring.is_a?(String)
			self.timestring.match /(\d+)\/(\d+)\/(\d+) (\d+):(\d+)/
			self.time = DateTime.civil($3.to_i, $1.to_i, $2.to_i, $4.to_i, $5.to_i)
			self.time += 4.hours
		elsif self.timestring != ""
			
		end

	end
end
