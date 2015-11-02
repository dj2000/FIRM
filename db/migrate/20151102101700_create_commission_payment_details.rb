class CreateCommissionPaymentDetails < ActiveRecord::Migration
  def change
    create_table :commission_payment_details do |t|
      t.integer :inspector_id
      t.integer :contract_id
      t.date :commission_date
      t.decimal :amount
      t.date :paid_date
      t.string :payment_reference
      t.timestamps
    end
  end
end
