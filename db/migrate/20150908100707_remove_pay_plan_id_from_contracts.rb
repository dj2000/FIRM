class RemovePayPlanIdFromContracts < ActiveRecord::Migration
  def change
  	remove_column :contracts, :payPlan_id, :integer
  end
end
