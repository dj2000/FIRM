class ChangeColumnTypeOfNumberOfDaysOfInspection < ActiveRecord::Migration
  def change
  	change_column :inspections, :nOD, :float
  end
end
