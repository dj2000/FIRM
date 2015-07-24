class CreateClientProperties < ActiveRecord::Migration
  def change
    create_table :client_properties do |t|
      t.integer :client_id
      t.integer :property_id
      t.string :clientType
      t.date :typeDate
      t.string :occupiedBy
      t.boolean :escrow
      t.date :escrowDate

      t.timestamps
    end
  end
end
