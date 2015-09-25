class ChangeDataTypesOfInspections < ActiveRecord::Migration
  def change
  	rename_column :inspections, :repairs?, :repairs
  	rename_column :inspections, :permit?, :permit
		rename_column :inspections, :paid?, :paid
  end
end
