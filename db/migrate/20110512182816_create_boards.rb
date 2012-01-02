class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :name
      t.text :about
      t.integer :chamber_id
      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
