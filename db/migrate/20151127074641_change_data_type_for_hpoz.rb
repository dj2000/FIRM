class ChangeDataTypeForHpoz < ActiveRecord::Migration
  def change
    @properties = Property.all
    remove_column :properties, :hpoz, :boolean
    add_column :properties, :hpoz, :string
    Property.reset_column_information
    @properties.each do |property|
      value = property.hpoz ? "Yes" : "No"
      property.update(hpoz: value)
    end
  end
end
