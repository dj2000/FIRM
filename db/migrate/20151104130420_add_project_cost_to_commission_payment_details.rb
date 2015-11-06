class AddProjectCostToCommissionPaymentDetails < ActiveRecord::Migration
  def change
    add_column :commission_payment_details, :project_cost, :decimal
  end
end
