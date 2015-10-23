class AddIsInsuranceToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :is_insurance, :boolean
  end
end
