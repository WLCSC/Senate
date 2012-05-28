class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title
      t.text :notes
      t.integer :chamber_id

      t.timestamps
    end
  end
end
