class AddReadyToProcessToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ready_to_process, :boolean
  end
end
