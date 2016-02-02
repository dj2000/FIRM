class Agent < ActiveRecord::Base
  extend AsCSV

  has_many :agent_clients, dependent: :destroy
  has_many :clients, through: :agent_clients, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  validates :firstName, :lastName, presence: true
  validates :phoneH, :phoneW, :phoneC,
  						uniqueness: true,
							length: { :minimum => 10, :maximum => 15, allow_blank: true },
              format: { with: /\A[0-9\-]+*\z/ }

  validates :email, email_format: { message: "Invalid Email Address" },if: :email?
  
  def name
    "#{self.try(:firstName)} #{self.try(:lastName)}"
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["First Name", "Last Name", "Middle Initial", "Company", "Home Number", "Work Number", "Cell Number", "Email","Mail Address"]
      all.each do |agent|
        row = [
                agent.firstName,
                agent.lastName,
                agent.middleInit,
                agent.company,
                ActionController::Base.helpers.number_to_phone(agent.phoneH),
                ActionController::Base.helpers.number_to_phone(agent.phoneW),
                ActionController::Base.helpers.number_to_phone(agent.phoneC),
                agent.email,
                agent.mailAddress
              ]
        csv << row
      end
    end
  end
end
