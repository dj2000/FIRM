class AddPrimaryCrewIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :primary_crew_id, :integer
  end
end
