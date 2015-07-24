class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :firstName
      t.string :lastName
      t.string :middleInit
      t.string :phoneH
      t.string :phoneW
      t.string :phoneC
      t.string :email
      t.text :mailAddress

      t.timestamps
    end
  end
end
