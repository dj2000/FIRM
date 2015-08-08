class ChangeDefaultValueOfEscrowInClientProperties < ActiveRecord::Migration
  def self.up
  	change_column_default :client_properties, :escrow, false
  	ClientProperty.reset_column_information
  	ClientProperty.where(escrow: nil).update_all(escrow: false)
  end
  def self.down
  	change_column_default :client_properties, :escrow, nil
  end
end
