class Bid < ActiveRecord::Base
  extend AsCSV

  belongs_to :inspection
  belongs_to :payPlan
  has_many :comm_histories
  has_one :contract
  has_one :verbal_close_comm_history, -> { where(callOutcome: "Verbal Close") }, class_name: 'CommHistory', foreign_key: 'bid_id'
  has_many :callback_comm_histories, -> { where(callOutcome: "Follow-up") }, class_name: 'CommHistory', foreign_key: 'bid_id'

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
    Bid.joins(:inspection => [:appointment => [:insp_request => [:property]]]).
      where('("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)',
      start_date, end_date, start_date, end_date)
  end

  def status_date
    if self.status == "Accepted"
      self.try(:verbal_close_comm_history).try(:call_time).try(:strftime, "%d %b %Y")
    elsif self.status == "Follow-up"
      self.try(:callback_comm_histories).try(:last).try(:callBackDate).try(:strftime, "%d %b %Y")
    end
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Bid", "Property Address", "Repair Cost", "Seismic Upgrade Fee", "Administration Fee", "Bid Total", "Payment Plan", "Bid Status", "Status Date"]
      all.each do |bid|
        row = [ bid.title,
           bid.try(:inspection).try(:appointment).try(:insp_request).try(:property).try(:property_select_value),
           bid.costRepair,
           bid.feeSeismicUpg,
           bid.feeAdmin,
           bid.total_cost,
           bid.try(:payPlan).try(:payment_plan_select),
           bid.status,
           bid.status_date]
        csv << row
      end
    end
  end

end