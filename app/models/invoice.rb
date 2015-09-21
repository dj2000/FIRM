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
    inspection = (self.try(:inspection) || self.try(:project).try(:contract).try(:bid).try(:inspection))
    inspection.try(:appointment).try(:inspFee)
  end
end