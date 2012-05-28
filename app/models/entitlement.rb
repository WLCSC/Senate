class Entitlement < ActiveRecord::Base
	belongs_to :title
	belongs_to :user
end
