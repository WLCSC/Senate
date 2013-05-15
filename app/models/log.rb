class Log < ActiveRecord::Base
	belongs_to :user
	belongs_to :chamber

	def action_item
		begin
			self.action_type.constantize.find(self.action_id)
		rescue
			return nil
		end
	end
end
