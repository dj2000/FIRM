class RemoveColumnAppointmentIdFromBlockOutPeriods < ActiveRecord::Migration
  def change
  	remove_column :block_out_periods, :appointment_id
  end
end
