class AddPermitToProjects < ActiveRecord::Migration
  def change
  	remove_column :inspections, :permit, :boolean
  	add_column :projects, :permit, :boolean
  end
end
