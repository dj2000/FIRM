class AddAgentTypeToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :agent_type, :string
  end
end
