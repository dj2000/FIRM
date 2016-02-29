class AddNotesInContracts < ActiveRecord::Migration
  def change
  	add_column :contracts, :notes, :text
  end
end
