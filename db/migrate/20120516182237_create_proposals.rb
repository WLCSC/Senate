class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :chamber_id
      t.boolean :closed

      t.timestamps
    end
  end
end
