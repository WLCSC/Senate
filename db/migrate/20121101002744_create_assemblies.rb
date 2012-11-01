class CreateAssemblies < ActiveRecord::Migration
  def change
    create_table :assemblies do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
