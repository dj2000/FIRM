class Bid < ActiveRecord::Base
  extend AsCSV

  belongs_to :inspection
  belongs_to :payPlan
  has_many :comm_histories
  has_one :contract
  has_one :verbal_close_comm_history, -> { where(callOutcome: "Verbal Close") }, class_name: 'CommHistory', foreign_key: 'bid_id'

  validates :costRepair, :feeSeismicUpg, :feeAdmin, :inspection_id, :title, :payPlan_id, presence: true

  before_create :default_status

  # where(appointments: { schedStart: start_date })}

  # Set default status as pending
  def default_status
		self.status = "Pending"
  end

  def total_cost
		total = 0
		[:costRepair, :feeSeismicUpg, :feeAdmin].each do |attribute|
			total += self.send(attribute)
		end
		total
  end

  def calculate_amount(percentage_amount, cost = nil)
    cost = cost ? cost : self.total_cost
    ((cost.to_f * percentage_amount.to_f) / 100).to_f if cost > 0.0
  end

  def self.uncontracted_bids
    bids = Contract.all.map(&:bid_id)
    self.where.not(id: bids)
  end

  def default_title(inspection)
    last_bid = Bid.last.try(:id) || 0
    id_val = self.new_record? ? (last_bid + 1) : (self.id)
    "#{inspection.try(:appointment).try(:insp_request).try(:property).try(:property_select_value)} -- (#{id_val})"
  end

  def self.accepted_bids
    bids = Bid.where(status: "Accepted")
  end

  def self.created_between(start_date, end_date)
    Bid.all.map { |bid| bid if
      (bid.inspection.appointment.schedStart.to_date >= start_date &&
      bid.inspection.appointment.schedStart.to_date <= end_date) &&
      (bid.inspection.appointment.schedEnd.to_date >= start_date &&
      bid.inspection.appointment.schedEnd.to_date >= end_date)}.compact
  end
end