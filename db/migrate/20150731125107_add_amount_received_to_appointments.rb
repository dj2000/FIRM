class AddAmountReceivedToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :amount_received, :boolean
  end
end
