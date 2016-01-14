class CreatePermitInformations < ActiveRecord::Migration
  def change
    create_table :permit_informations do |t|
      t.integer :valuation
      t.boolean :replacement
      t.string :type_of_replacement
      t.integer :amount
      t.boolean :engineering
      t.integer :engineer_id
      t.boolean :units
      t.integer :project_id
      t.timestamps
    end
  end
end
