class ChangePropertiesNumberColumnToString < ActiveRecord::Migration
  def change
    change_column :properties, :number, :string
  end
end
