class CreateInspectors < ActiveRecord::Migration
  def change
    create_table :inspectors do |t|
      t.string :firstName
      t.string :lastName
      t.string :middleInit
      t.boolean :senior
      t.string :phoneH
      t.string :phoneC
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :email

      t.timestamps
    end
  end
end
