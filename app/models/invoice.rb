class Invoice < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :project
  has_many :receipts

  validates :reference, :invoice_type, :description, :invoiceDate, :amount, :due_date, presence: true

  validates :inspection_id, presence: true, if: Proc.new{|i| i.invoice_type == "Inspection"}
  validates :project_id, presence: true, if: Proc.new{|i| i.invoice_type == "Project"}

  ## For getting client name of respective inspection or project
  def client
		inspection = (self.try(:inspection) || self.try(:project).try(:contract).try(:bid).try(:inspection))
		inspection.try(:appointment).try(:insp_request).try(:client)
  end

  def pay_plan
		self.try(:project).try(:contract).try(:bid).try(:payPlan)
  end

  def balance_due
    contract = self.try(:project).try(:contract)
    inspection = (self.try(:inspection) || bid.try(:inspection))
    if self.invoice_type == "Inspection"
      inspection.try(:appointment).try(:inspFee)
    elsif self.invoice_type == "Project"
      contract.try(:balance)
    end
  end

  def invoice_select_dropdown
    "#{self.invoice_type} - #{self.reference}"
  end
end