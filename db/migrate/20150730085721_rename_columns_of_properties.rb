class RenameColumnsOfProperties < ActiveRecord::Migration
  def change
  	rename_column :properties, :type, :prop_type
  	rename_column :properties, :cdo?, :cdo
  	rename_column :properties, :hpoz?, :hpoz
  	add_column :properties, :occupied_by, :string
  end
end
