class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :chamber_id
      t.integer :action_id
      t.string :action_type
      t.string :comment

      t.timestamps
    end
  end
end
