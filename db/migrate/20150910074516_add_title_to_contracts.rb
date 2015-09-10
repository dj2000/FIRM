class AddTitleToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :title, :string
  end
end
