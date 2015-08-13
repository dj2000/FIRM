class AgentClient < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  validates :agent_id, :client_id, presence: true
  validates :agent_id, uniqueness: { scope: :client_id }
end
