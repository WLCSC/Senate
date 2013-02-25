class Log < ActiveRecord::Base
	belongs_to :user
	belongs_to :chamber

	def action_item
		self.action_type.constantize.find(self.action_id)
	end
end
