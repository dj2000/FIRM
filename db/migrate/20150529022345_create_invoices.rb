class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :reference
      t.string :type
      t.string :inspection_id
      t.string :project_id
      t.string :description
      t.date :invoiceDate
      t.decimal :amount

      t.timestamps
    end
  end
end
