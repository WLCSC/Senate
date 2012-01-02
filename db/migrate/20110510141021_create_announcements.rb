class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
