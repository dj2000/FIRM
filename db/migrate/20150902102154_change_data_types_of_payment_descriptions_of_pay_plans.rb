class ChangeDataTypesOfPaymentDescriptionsOfPayPlans < ActiveRecord::Migration
  def change
  	change_column :pay_plans, :pmt1Desc, :string
  	change_column :pay_plans, :pmt2Desc, :string
  	change_column :pay_plans, :pmt3Desc, :string
  	change_column :pay_plans, :pmt4Desc, :string
  	change_column :pay_plans, :pmt5Desc, :string
  end
end
