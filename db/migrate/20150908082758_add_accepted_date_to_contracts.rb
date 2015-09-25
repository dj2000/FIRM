class AddAcceptedDateToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :accepted_date, :date
  end
end
