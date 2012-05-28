class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :title
      t.integer :chamber_id
      t.text :notes

      t.timestamps
    end
  end
end
