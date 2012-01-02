class CreateProposalRemarks < ActiveRecord::Migration
  def self.up
    create_table :proposal_remarks do |t|
      t.integer :user_id
      t.integer :proposal_id
      t.integer :remark
      t.timestamps
    end
  end

  def self.down
    drop_table :proposal_remarks
  end
end
