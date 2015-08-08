class ChangeColumnTypesOfAppointments < ActiveRecord::Migration
  def self.up
  	change_column :appointments, :amount_received, :float
  	change_column :appointments, :inspFee, :float
  end
  def self.down
  	change_column :appointments, :amount_received, :integer
  	change_column :appointments, :inspFee, :integer
  end
end
