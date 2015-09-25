class AddConfirmedByToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :confirmed_by, :string
  end
end
