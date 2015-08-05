class ChangeDataTypesOfAppointments < ActiveRecord::Migration
  def self.up
  	change_column :appointments, :amount_received, :decimal, precision: 5, scale: 3
  	change_column :appointments, :inspFee, :decimal, precision: 5, scale: 3
  end
  def self.down
  	change_column :appointments, :amount_received, :boolean
  	change_column :appointments, :inspFee, :integer
  end
end
