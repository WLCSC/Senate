class CreateChambers < ActiveRecord::Migration
  def change
    create_table :chambers do |t|
      t.string :title
      t.text :about

      t.timestamps
    end
  end
end
