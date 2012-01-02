class CreateBallots < ActiveRecord::Migration
  def self.up
    create_table :ballots do |t|
      t.string :name
      t.text :content
      t.text :options
	  t.boolean :closed
      t.integer :creator_id
	  t.integer :chamber_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ballots
  end
end
