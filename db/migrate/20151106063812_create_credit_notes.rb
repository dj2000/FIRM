class CreateCreditNotes < ActiveRecord::Migration
  def change
    create_table :credit_notes do |t|
      t.string :reference
      t.date :date
      t.integer :invoice_id
      t.decimal :amount
      t.string :received_by

      t.timestamps
    end
  end
end
