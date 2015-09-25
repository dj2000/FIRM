class Agent < ActiveRecord::Base
  has_many :agent_clients, dependent: :destroy
  has_many :clients, through: :agent_clients, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  validates :firstName, :lastName, presence: true
  validates :phoneH, :phoneW, :phoneC,
  						uniqueness: true,
							length: { :minimum => 10, :maximum => 15, allow_blank: true },
              format: { with: /\A[0-9\-]+*\z/ }

  validates :email, email_format: { message: "Invalid Email Address" }
  def name
    "#{self.try(:firstName)} #{self.try(:lastName)}"
  end
end
