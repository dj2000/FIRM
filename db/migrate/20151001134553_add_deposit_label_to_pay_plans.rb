class AddDepositLabelToPayPlans < ActiveRecord::Migration
  def change
    add_column :pay_plans, :deposit_label, :string
  end
end
