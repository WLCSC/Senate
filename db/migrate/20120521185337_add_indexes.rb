class AddIndexes < ActiveRecord::Migration
  def change
	  add_index :memberships, [:user_id, :group_id], :unique => true
  end
end
