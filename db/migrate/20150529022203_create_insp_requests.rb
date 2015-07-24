class CreateInspRequests < ActiveRecord::Migration
  def change
    create_table :insp_requests do |t|
      t.datetime :callTime
      t.string :callerType
      t.string :referalSource
      t.integer :client_id
      t.integer :agent_id
      t.integer :property_id
      t.string :selectInsp

      t.timestamps
    end
  end
end
