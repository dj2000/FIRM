class ChangeDataTypeForHpoz < ActiveRecord::Migration
  def change
    properties_hash = Hash.new
    Property.all.each do |property|
      properties_hash[property.id] = property.hpoz? ? "Yes" : "No"
    end
    remove_column :properties, :hpoz, :boolean
    add_column :properties, :hpoz, :string
    Property.reset_column_information
    Property.all.each do |property|
      property.update(hpoz: properties_hash[property.id])
    end
  end
end
