class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.string :authorizable_type
      t.integer :authorizable_id

      t.timestamps
    end
  end
end
