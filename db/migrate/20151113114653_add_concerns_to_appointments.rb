class AddConcernsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :concerns, :text
  end
end
