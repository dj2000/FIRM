class Contract < ActiveRecord::Base
  belongs_to :bid
  has_one :project, dependent: :destroy
  has_many :pmt_schedules, dependent: :destroy

  attr_accessor :accepted, :signed, :down_payment

  validates :bid_id, :date, :title, presence: true

  validates :acceptedBy, :accepted_date, presence: true, if: Proc.new { |a| a.accepted == "1" }

	validates :dateSigned, :signedBy, presence: true, if: Proc.new { |a| a.signed == "1" }

	validates :downPmtDate, :downPmtAmt, :deposit_payment_method, presence: true, if: Proc.new { |a| a.down_payment == "1" }

  validate :down_payment_amount, if: Proc.new { |a| a.down_payment == "1" }

  PAYMENT_METHOD = ["Cash", "Check", "Credit Card", "Escrow", "Scan", "Fax", "On-Site"]

  def accepted?(params = nil)
    (params and params[:accepted] and params[:accepted] == "1") || (self.accepted_date and self.acceptedBy)
  end

  def signed?(params = nil)
		return true if (params and params[:signed] and params[:signed] == "1") || (self.dateSigned and self.signedBy)
  end

  def down_payment?(params = nil)
		return true if (params and params[:down_payment] and params[:down_payment] == "1") || (self.downPmtAmt and self.downPmtDate)
  end

  ## Contracts doesn't have any project
  def self.unprojected_contracts
    projects = Project.all.map(&:contract_id)
    Contract.where.not(id: projects)
  end

  ## Calculating balance due for Invoice
  def balance
    (self.try(:bid).try(:total_cost) - (self.try(:downPmtAmt) || 0 ))
  end

  ## Scale for contract's amount
  def calculate_scale(amount, inspector_id)
    percentage_amount = 0
    commissions = Commission.where(inspector_id: inspector_id)
    commissions.each do |c|
      percentage_amount = c.percentage if c.scale.include?(amount)
    end
    percentage_amount
  end

  def calculate_amount(amount, percentage)
    calculated_amount = 0
    calculated_amount = self.bid.try(:calculate_amount, percentage, amount)
  end

  ## Calculate commission for contract
  def self.calculate_commissions(start_date, end_date, inspector_id)
    records = Hash.new{ |h, k| h[k] = {} }
    paid_off_contracts = paid_off_contracts(start_date, end_date, inspector_id)
    paid_off_contracts.each do |contract_id, record|
			contract = record["contract"]
      if contract.accepted?
        contract_hash = records[contract.id]
        contract_hash["title"] = contract.title
        total_sales_amount = contract.calculate_total_sales_of_inspector(inspector_id)
        scale = contract.calculate_scale(total_sales_amount, inspector_id)
        commission = contract.calculate_amount(total_sales_amount, scale)
        contract_hash["commission"] = commission
        contract_hash["total_sales_amount"] = total_sales_amount
        contract_hash["rate"] = scale
        contract_hash["paid_date"] = record["paid_date"]
      end
    end
    records
  end

  ## Contracts which are paid off
  def self.paid_off_contracts(start_date, end_date, inspector_id)
    paid_off_contracts = Hash.new{ |h, k| h[k] = {} }
    receipts = Receipt.joins(:invoice => [:project => [:contract => [ :bid => [inspection: :appointment]]]]).
                where(appointments: {inspector_id: inspector_id }).group_by{|r| r.invoice.project_id}
    receipts.each do |project_id, receipts|
      invoice = receipts.first.invoice
      project = Project.find(project_id)
      total_amount = receipts.map(&:amount).inject(:+) + (invoice.try(:credit_notes).map(&:amount).inject(:+) || 0)
      contract = project.contract
      project_cost = contract.balance
      date = receipts.last.date
      if (project_cost == total_amount and date.between?(start_date, end_date))
				paid_off_contracts[contract.id]["contract"] = contract
				paid_off_contracts[contract.id]["paid_date"] = date
      end
    end
    paid_off_contracts
  end

  ## Total Sales for inspector
  def calculate_total_sales_of_inspector(inspector_id)
    accepted_date = self.try(:accepted_date)
    start_date = accepted_date.beginning_of_week
    end_date = accepted_date.end_of_week
    contracts = Contract.joins(:bid => [:inspection => :appointment]).
                          where("appointments.inspector_id = ? AND (accepted_date BETWEEN (?) AND (?))", inspector_id, start_date, end_date)
    contracts.map(&:balance).inject(:+)
  end

  def self.created_between(start_date, end_date)
    Contract.where('("date" BETWEEN ? AND ?)', start_date, end_date)
  end

  def self.signed_contracts(start_date = nil, end_date = nil)
    @contracts = (start_date and end_date) ? Contract.where('date BETWEEN ? AND ?', start_date, end_date) : Contract.all
    @contracts = @contracts.map{|c| c if c.signed?}.compact
  end

  private
  def down_payment_amount
    bid = self.try(:bid)
    self.errors.add(:downPmtAmt, "Amount Received should not be greater than bid's total.") if self.downPmtAmt > 0 and bid.try(:total_cost) < self.downPmtAmt
  end
end
