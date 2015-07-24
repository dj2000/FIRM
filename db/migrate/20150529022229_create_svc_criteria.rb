class CreateSvcCriteria < ActiveRecord::Migration
  def change
    create_table :svc_criteria do |t|
      t.boolean :propRes
      t.boolean :propComm
      t.string :prevInsp
      t.string :hpoz
      t.string :cdo
      t.boolean :ownerOcc
      t.string :foundation
      t.integer :yearBuilt
      t.text :notes

      t.timestamps
    end
  end
end
