class Agent < ActiveRecord::Base
  has_many :agent_clients
  has_many :clients, through: :agent_clients
  has_many :insp_requests

  validates :firstName, :lastName, :middleInit, :phoneH, :phoneW, :phoneC, presence: true
  validates :phoneH, :phoneW, :phoneC,
  						uniqueness: true,
  						numericality: true,
  						length: { :minimum => 10, :maximum => 15 }

  validates :email, email_format: { message: "Invalid Email Address" }

end
