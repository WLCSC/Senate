class AddParentToChamber < ActiveRecord::Migration
  def change
    add_column :chambers, :assembly_id, :integer

  end
end
