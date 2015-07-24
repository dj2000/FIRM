class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :inspection_id
      t.decimal :costRepair
      t.decimal :feeSeismicUpg
      t.decimal :feeAdmin
      t.integer :payPlan_id
      t.string :status

      t.timestamps
    end
  end
end
