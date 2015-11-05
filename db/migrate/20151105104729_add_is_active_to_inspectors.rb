class AddIsActiveToInspectors < ActiveRecord::Migration
  def change
    add_column :inspectors, :is_active, :boolean, default: true
    Inspector.reset_column_information
    Inspector.update_all(is_active: true)
  end
end
