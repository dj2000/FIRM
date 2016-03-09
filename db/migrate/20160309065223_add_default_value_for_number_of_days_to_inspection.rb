class AddDefaultValueForNumberOfDaysToInspection < ActiveRecord::Migration
  def change
  	change_column :inspections, :nOG, :float, :default => 0.0
  	change_column :inspections, :nOD, :float, :default => 0.0
  	Inspection.reset_column_information
  	Inspection.where(nOG: nil).update_all(nOG: 0.0)
  	Inspection.where(nOD: nil).update_all(nOD: 0.0)
  end
end
