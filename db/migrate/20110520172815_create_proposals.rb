class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.string :name
      t.text :content
      t.integer :creator_id
      t.integer :chamber_id
      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
