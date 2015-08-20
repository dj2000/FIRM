class AddNotesToSvcAreas < ActiveRecord::Migration
  def change
  	add_column :svc_areas, :notes, :string, limit: 25
  end
end
