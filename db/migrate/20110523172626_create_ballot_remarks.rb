class CreateBallotRemarks < ActiveRecord::Migration
  def self.up
    create_table :ballot_remarks do |t|
      t.integer :user_id
      t.integer :ballot_id
      t.integer :remark
      t.timestamps
    end
  end

  def self.down
    drop_table :ballot_remarks
  end
end
