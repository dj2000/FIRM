class ChangeColumnTypeDescriptionToTextOfInvoices < ActiveRecord::Migration
  def change
  	change_column :invoices, :description, :text
  end
end
