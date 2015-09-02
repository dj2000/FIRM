class AddColumnDepositToPayPlans < ActiveRecord::Migration
  def change
    add_column :pay_plans, :deposit, :integer
  end
end
