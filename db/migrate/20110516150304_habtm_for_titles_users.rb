class HabtmForTitlesUsers < ActiveRecord::Migration
  def self.up
	create_table :titles_users, :id => false do |t|
		t.integer :title_id
		t.integer :user_id
	end
  end

  def self.down
	drop_table :titles_users
  end
end
