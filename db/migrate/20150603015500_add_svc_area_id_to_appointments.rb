class AddSvcAreaIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :svcArea_id, :integer
  end
end
