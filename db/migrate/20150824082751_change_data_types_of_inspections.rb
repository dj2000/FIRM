class ChangeDataTypesOfInspections < ActiveRecord::Migration
  def change
  	rename_column :inspections, :repairs?, :repairs
  	rename_column :inspections, :permit?, :permit
  end
end
