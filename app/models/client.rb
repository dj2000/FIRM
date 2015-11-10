class Client < ActiveRecord::Base
  has_many :client_properties, dependent: :destroy
  has_many :properties, through: :client_properties, dependent: :destroy
  has_many :agent_clients, dependent: :destroy
  has_many :agents, through: :agent_clients, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  validates :firstName, :lastName, presence: true
  validates :phoneH, :phoneW, :phoneC,
              length: { :minimum => 10, :maximum => 15, allow_blank: true },
              format: { with: /\A[0-9\-]*\z/ }

  validates :email, email_format: { message: "Invalid Email Address" }

  def name
    "#{self.try(:firstName)} #{self.try(:lastName)}"
  end

  def opt_out_mailer?
    self.is_opt_out_mailer ? "Yes" : "No"
  end
end
