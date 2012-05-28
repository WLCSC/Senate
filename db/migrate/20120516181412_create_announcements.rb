class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :content
      t.integer :user_id
      t.integer :chamber_id

      t.timestamps
    end
  end
end
