class ChangeColumnNameOfCommissionPaymentDetails < ActiveRecord::Migration
  def change
  	remove_column :commission_payment_details, :commission_date
  	add_column :commission_payment_details, :commission_rate, :decimal
  end
end
