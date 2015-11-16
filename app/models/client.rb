class Client < ActiveRecord::Base
  has_many :client_properties, dependent: :destroy
  has_many :properties, through: :client_properties, dependent: :destroy
  has_many :agent_clients, dependent: :destroy
  has_many :agents, through: :agent_clients, dependent: :destroy
  has_many :insp_requests, dependent: :destroy
  has_many :associated_customers, class_name: "Client", foreign_key: "parent_id"

  validates :firstName, :lastName, presence: true, if: lambda { |o| o.of_type == "Individual" or o.of_type.blank? }
  validates :phoneH, :phoneW, :phoneC,
              length: { :minimum => 10, :maximum => 15, allow_blank: true },
              format: { with: /\A[0-9\-]*\z/ }

  validates :email, email_format: { message: "Invalid Email Address" }

  validates :company_name, presence: true, if: lambda { |o| o.of_type == "Company" }

  accepts_nested_attributes_for :associated_customers, allow_destroy: true

  CLIENT_TYPE = %w(Buyer Owner Seller Contractor Other)

  def name
    (self.of_type == "Individual" or self.of_type.nil?) ? "#{self.try(:firstName)} #{self.try(:middleInit)} #{self.try(:lastName)}" : self.company_name
  end

  def opt_out_mailer?
    self.is_opt_out_mailer ? "Yes" : "No"
  end

  def clienttype
    return nil if self.client_type.nil?
    client_type = (Client::CLIENT_TYPE.first(4)).include?(self.client_type) ? self.client_type : "Other"
  end
end
