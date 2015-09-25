class AddReportToInspections < ActiveRecord::Migration
  def change
  	add_attachment :inspections, :report
  	remove_column :inspections, :reportURL
  end
end
