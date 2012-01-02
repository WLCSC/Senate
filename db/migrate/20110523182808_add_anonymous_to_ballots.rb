class AddAnonymousToBallots < ActiveRecord::Migration
  def self.up
    add_column :ballots, :anonymous, :boolean
  end

  def self.down
    remove_column :ballots, :anonymous
  end
end
