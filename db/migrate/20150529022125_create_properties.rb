class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :number
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :crossStreet
      t.integer :mapPage
      t.integer :yearBuilt
      t.integer :size
      t.integer :stories
      t.string :type
      t.integer :units
      t.integer :gndUnits
      t.string :lotType
      t.string :foundation
      t.boolean :hpoz?
      t.boolean :cdo?

      t.timestamps
    end
  end
end
