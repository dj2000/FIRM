class Client < ActiveRecord::Base
  extend AsCSV

  default_scope { order('created_at asc') }

  attr_accessor :client_type_other

  has_many :client_properties, dependent: :destroy
  has_many :properties, through: :client_properties, dependent: :destroy
  has_many :agent_clients, dependent: :destroy
  has_many :agents, through: :agent_clients, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  validates :firstName, :lastName, presence: true, if: lambda { |o| o.of_type == "Individual" or o.of_type.blank? }
  validates :phoneH, :phoneW, :phoneC,
              length: { :minimum => 10, :maximum => 15, allow_blank: true },
              format: { with: /\A[0-9\-]*\z/ }

  validates :email, email_format: { message: "Invalid Email Address" },if: :email?

  validates :company_name, presence: true, if: lambda { |o| o.of_type == "Company" }

  CLIENT_TYPE = %w(Buyer Owner Seller Contractor Other)

  def name
    (self.of_type == "Individual" or self.of_type.nil?) ? self.full_name : self.company_name
  end

  def opt_out_mailer?
    self.is_opt_out_mailer ? "Yes" : "No"
  end

  def clienttype
    return nil if self.client_type.nil?
    client_type = (Client::CLIENT_TYPE.first(4)).include?(self.client_type) ? self.client_type : "Other"
  end

  def full_name
    "#{self.try(:firstName)} #{self.try(:middleInit)} #{self.try(:lastName)}"
  end

  def contact
    self.full_name
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Name", "Home Number", "Office Number", "Cell Number", "Email", "Client Type", "Opt Out of Mailing List", "Mail Address"]
      all.each do |client|
        row = [
                client.name,
                ActionController::Base.helpers.number_to_phone(client.phoneH),
                ActionController::Base.helpers.number_to_phone(client.phoneW),
                ActionController::Base.helpers.number_to_phone(client.phoneC),
                client.email,
                client.client_type,
                client.opt_out_mailer?,
                client.mailAddress
              ]
        csv << row
      end
    end
  end
end
