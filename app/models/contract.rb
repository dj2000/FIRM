class Contract < ActiveRecord::Base
  belongs_to :bid
  has_one :commission
  has_one :project
  has_many :pmt_schedules

  attr_accessor :accepted, :signed, :down_payment

  validates :bid_id, :date, :title, presence: true

  validates :acceptedBy, :accepted_date, presence: true, if: Proc.new { |a| a.accepted == "1" }

	validates :dateSigned, :signedBy, presence: true, if: Proc.new { |a| a.signed == "1" }

	validates :downPmtDate, :downPmtAmt, presence: true, if: Proc.new { |a| a.down_payment == "1" }

  validate :down_payment_amount, if: Proc.new { |a| a.down_payment == "1" }

  def accepted?(params = nil)
    (params and params[:accepted] and params[:accepted] == "1") || (self.accepted_date and self.acceptedBy)
  end

  def signed?(params = nil)
		(params and params[:signed] and params[:signed] == "1") || (self.dateSigned and self.signedBy)
  end

  def down_payment?(params = nil)
		(params and params[:down_payment] and params[:down_payment] == "1") || (self.downPmtAmt and self.downPmtDate)
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

  ## Calculation of commission for each contract
  def calculate_commission
    bid = self.try(:bid)
    amount = 0
    project_cost = bid.try(:total_cost)
    inspector_id = bid.try(:inspection).try(:appointment).try(:inspector_id)
    commissions = Commission.joins(:inspector, :commission_rate).where(inspector_id: inspector_id)
    commissions.each do |c|
      if c.scale.include?(project_cost)
        percentage_amount = c.percentage
        amount = ((project_cost * percentage_amount) / 100).to_f
      end
    end
    amount
  end

  private
  def down_payment_amount
    bid = self.try(:bid)
    self.errors.add(:downPmtAmt, "Amount Received should not be greater than bid's total.") if self.downPmtAmt > 0 and bid.try(:total_cost) < self.downPmtAmt
  end
end
