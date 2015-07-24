class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.integer :appointment_id
      t.string :fCondition
      t.boolean :businessCards
      t.integer :nOD
      t.integer :nOG
      t.boolean :paid?
      t.string :reportURL
      t.string :footprintURL
      t.boolean :repairs?
      t.boolean :permit?
      t.boolean :interiorAccess
      t.boolean :verifiedReport
      t.boolean :verifiedComp
      t.text :notes

      t.timestamps
    end
  end
end
