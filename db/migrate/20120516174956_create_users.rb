class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.boolean :administrator
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
