class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.string :title
      t.text :content
      t.text :options
      t.boolean :closed
      t.integer :user_id
      t.integer :chamber_id
      t.boolean :anonymous

      t.timestamps
    end
  end
end
