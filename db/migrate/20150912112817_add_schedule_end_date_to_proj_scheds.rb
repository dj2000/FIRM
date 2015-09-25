class AddScheduleEndDateToProjScheds < ActiveRecord::Migration
  def change
    add_column :proj_scheds, :schedule_end_date, :date
    rename_column :proj_scheds, :date, :schedule_start_date
  end
end
