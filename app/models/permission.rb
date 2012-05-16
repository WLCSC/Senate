class Permission < ActiveRecord::Base
belongs_to :principal
belongs_to :securable, :polymorphic => true
end
