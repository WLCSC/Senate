class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :auth_attribute
      t.string :auth_value

      t.timestamps
    end
  end
end
