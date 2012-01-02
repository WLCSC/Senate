class AddClosedToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :closed, :integer
  end

  def self.down
    remove_column :proposals, :closed
  end
end
