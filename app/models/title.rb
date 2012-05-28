class Title < ActiveRecord::Base
	belongs_to :chamber
	has_many :entitlements
	has_many :users, :through => :entitlements
end
