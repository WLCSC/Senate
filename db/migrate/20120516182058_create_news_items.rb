class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
