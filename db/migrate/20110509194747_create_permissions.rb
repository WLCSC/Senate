class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :name
      t.string :priority
      t.boolean :readable
      t.boolean :commentable
      t.boolean :proposable
      t.boolean :remarkable
      t.boolean :votable
	  t.integer :chamber_id
	  t.integer :principal_id
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
