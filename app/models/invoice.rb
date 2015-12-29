class Invoice < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :project
  has_many :receipts, dependent: :destroy
  has_many :credit_notes, dependent: :destroy

  attr_accessor :balanceDue

  validates :reference, :invoice_type, :description, :invoiceDate, :amount, :due_date, presence: true

  validates :inspection_id, presence: true, if: Proc.new{|i| i.invoice_type == "Inspection"}
  validates :project_id, presence: true, if: Proc.new{|i| i.invoice_type == "Project"}
  validate :check_balance_due

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
    inspection = (self.try(:inspection) || contract.try(:bid).try(:inspection))
    if self.invoice_type == "Inspection"
      inspection.try(:amount)
    elsif self.invoice_type == "Project"
      contract.try(:balance)
    end
  end

  def invoice_select_dropdown
    "#{self.invoice_type} - #{self.reference}"
  end

  private

  def check_balance_due
    self.errors.add(:amount, "Amount can not be greater than Balance Due.") if (self.balanceDue and self.balanceDue.to_f < self.amount)
  end
end