class AddChamberToAnnouncements < ActiveRecord::Migration
  def self.up
    add_column :announcements, :chamber_id, :integer
  end

  def self.down
    remove_column :announcements, :chamber_id
  end
end
