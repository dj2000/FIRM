class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :reference
      t.date :date
      t.integer :invoice_id
      t.decimal :amount
      t.string :recBy

      t.timestamps
    end
  end
end
