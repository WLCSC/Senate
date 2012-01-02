class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.text :about
	  t.string :auth_attribute
	  t.string :auth_value
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
