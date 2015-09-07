class RemovePaymentColumnsFromPayPlans < ActiveRecord::Migration
  def change
  	remove_column :pay_plans, :pmt1Pcnt
  	remove_column :pay_plans, :pmt1Desc
  	remove_column :pay_plans, :pmt2Pcnt
  	remove_column :pay_plans, :pmt2Desc
  	remove_column :pay_plans, :pmt3Pcnt
  	remove_column :pay_plans, :pmt3Desc
  	remove_column :pay_plans, :pmt4Pcnt
  	remove_column :pay_plans, :pmt4Desc
  	remove_column :pay_plans, :pmt5Pcnt
  	remove_column :pay_plans, :pmt5Desc
  end
end
