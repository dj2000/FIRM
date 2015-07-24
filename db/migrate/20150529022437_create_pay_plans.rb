class CreatePayPlans < ActiveRecord::Migration
  def change
    create_table :pay_plans do |t|
      t.integer :jobMinAmt
      t.integer :jobMaxAmt
      t.integer :pmt1Pcnt
      t.integer :pmt2Pcnt
      t.integer :pmt3Pcnt
      t.integer :pmt4Pcnt
      t.integer :pmt5Pcnt
      t.integer :pmt1Desc
      t.integer :pmt2Desc
      t.integer :pmt3Desc
      t.integer :pmt4Desc
      t.integer :pmt5Desc

      t.timestamps
    end
  end
end
