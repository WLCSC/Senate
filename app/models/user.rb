class User < ActiveRecord::Base
has_many :memberships
has_many :groups, :through => :memberships
has_one :principal, :as => :authorizable
has_many :permissions, :through => :principal
end
