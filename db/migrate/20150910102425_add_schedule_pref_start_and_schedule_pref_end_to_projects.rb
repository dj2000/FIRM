class AddSchedulePrefStartAndSchedulePrefEndToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :schedule_pref_start, :date
    add_column :projects, :schedule_pref_end, :date
  end
end
