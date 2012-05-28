class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :notes
      t.integer :chamber_id
      t.timestamp :time

      t.timestamps
    end
  end
end
