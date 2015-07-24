class Client < ActiveRecord::Base
  has_many :client_properties
  has_many :properties, through: :client_properties
  has_many :agent_clients
  has_many :agents, through: :agent_clients
  has_many :insp_requests
end
