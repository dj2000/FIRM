class AddDepositPaymentMethodToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :deposit_payment_method, :string
  end
end
