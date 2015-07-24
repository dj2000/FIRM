class CreateAgentClients < ActiveRecord::Migration
  def change
    create_table :agent_clients do |t|
      t.integer :agent_id
      t.integer :client_id
      t.date :agentDate

      t.timestamps
    end
  end
end
