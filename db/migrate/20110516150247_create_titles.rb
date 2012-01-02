class CreateTitles < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.string :text
      t.text :about
      t.integer :chamber_id
      t.timestamps
    end
  end

  def self.down
    drop_table :titles
  end
end
