class Client < ActiveRecord::Base
  has_many :client_properties, dependent: :destroy
  has_many :properties, through: :client_properties, dependent: :destroy
  has_many :agent_clients, dependent: :destroy
  has_many :agents, through: :agent_clients, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  validates :firstName, :lastName, :phoneH, :phoneW, :phoneC, presence: true
  validates :phoneH, :phoneW, :phoneC,
  						uniqueness: true,
  						numericality: true,
  						length: { :minimum => 10, :maximum => 15 }

  validates :email, email_format: { message: "Invalid Email Address" }
end
