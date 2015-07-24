class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :firstName
      t.string :lastName
      t.string :middleInit
      t.string :company
      t.string :phoneH
      t.string :phoneW
      t.string :phoneC
      t.string :email
      t.text :mailAddress

      t.timestamps
    end
  end
end
