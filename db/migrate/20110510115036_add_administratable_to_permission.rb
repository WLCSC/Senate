class AddAdministratableToPermission < ActiveRecord::Migration
  def self.up
    add_column :permissions, :administratable, :boolean
  end

  def self.down
    remove_column :permissions, :administratable
  end
end
