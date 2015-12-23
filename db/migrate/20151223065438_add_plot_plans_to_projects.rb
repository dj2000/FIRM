class AddPlotPlansToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :plot_plans, :boolean, default: false
    add_column :projects, :drawings, :boolean, default: false
    add_column :projects, :option, :string
  end
end
