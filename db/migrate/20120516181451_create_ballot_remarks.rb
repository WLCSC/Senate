class CreateBallotRemarks < ActiveRecord::Migration
  def change
    create_table :ballot_remarks do |t|
      t.integer :user_id
      t.integer :ballot_id
      t.integer :remark

      t.timestamps
    end
  end
end
