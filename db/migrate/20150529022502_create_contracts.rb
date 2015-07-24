class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :bid_id
      t.integer :payPlan_id
      t.date :date
      t.string :signedBy
      t.string :acceptedBy
      t.date :dateSigned
      t.decimal :downPmtAmt
      t.date :downPmtDate

      t.timestamps
    end
  end
end
