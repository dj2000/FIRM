class CreateProjectPaymentSchedules < ActiveRecord::Migration
  def change
    create_table :project_payment_schedules do |t|
      t.integer :project_id
      t.integer :payment_id
      t.string :payment_schedule
      t.float :amount
      t.string :payment_type
      t.date :invoice_date
      t.boolean :paid
      t.date :date_paid
      t.text :comments
      t.timestamps
    end
  end
end
