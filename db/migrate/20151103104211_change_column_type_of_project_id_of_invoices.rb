class ChangeColumnTypeOfProjectIdOfInvoices < ActiveRecord::Migration
  def change
  	invoice_records = {}
  	invoices = Invoice.all
  	invoices.each do |invoice|
  		invoice_records[invoice.id] = invoice.project_id
  	end
  	remove_column :invoices, :project_id
  	add_column :invoices, :project_id, :integer
  	Invoice.reset_column_information
  	invoices.each do |i|
  		i.update(project_id: invoice_records[i.id])
  	end
  end
end
