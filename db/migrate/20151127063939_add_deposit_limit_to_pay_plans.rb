class AddDepositLimitToPayPlans < ActiveRecord::Migration
  def change
	add_column :pay_plans, :deposit_limit, :float
	PayPlan.reset_column_information
	PayPlan.update_all(deposit_limit: 0)
  end
end
