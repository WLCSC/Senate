class Principal < ActiveRecord::Base
has_many :permissions
belongs_to :authorizable, :polymorphic => :true
end
