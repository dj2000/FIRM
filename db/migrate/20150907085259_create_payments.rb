class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :title
      t.integer :value
      t.integer :pay_plan_id
      t.timestamps
    end
  end
end
