class AddFileFieldsToInspections < ActiveRecord::Migration
  def change
  	add_attachment :inspections, :completed_appointment_sheet
  	add_attachment :inspections, :client_information_sheet
  	add_attachment :inspections, :footprint_diagram
  end
end
