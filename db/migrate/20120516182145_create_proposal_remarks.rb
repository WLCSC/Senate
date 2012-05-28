class CreateProposalRemarks < ActiveRecord::Migration
  def change
    create_table :proposal_remarks do |t|
      t.integer :user_id
      t.integer :proposal_id
      t.integer :remark

      t.timestamps
    end
  end
end
