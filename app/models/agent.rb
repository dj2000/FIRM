class Agent < ActiveRecord::Base
  has_many :agent_clients
  has_many :clients, through: :agent_clients
  has_many :insp_requests
end
