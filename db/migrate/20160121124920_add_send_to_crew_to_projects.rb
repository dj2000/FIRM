class AddSendToCrewToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :send_to_crew, :boolean
  end
end
