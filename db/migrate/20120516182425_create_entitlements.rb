class CreateEntitlements < ActiveRecord::Migration
  def change
    create_table :entitlements do |t|
      t.integer :title_id
      t.integer :user_id

      t.timestamps
    end
  end
end
