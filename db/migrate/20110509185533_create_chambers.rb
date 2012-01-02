class CreateChambers < ActiveRecord::Migration
  def self.up
    create_table :chambers do |t|
      t.string :name
      t.text :about
      t.timestamps
    end
  end

  def self.down
    drop_table :chambers
  end
end
