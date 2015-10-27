class Bid < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :payPlan
  has_many :comm_histories
  has_one :verbal_close_comm_history, -> { where(callOutcome: "Verbal Close") }, class_name: 'CommHistory', foreign_key: 'bid_id'

  validates :costRepair, :feeSeismicUpg, :feeAdmin, :inspection_id, :title, :payPlan_id, presence: true

  before_create :default_status

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

  def calculate_amount(percentage_amount)
    ((self.total_cost * percentage_amount) / 100).to_f if self.total_cost > 0
  end

  def self.uncontracted_bids
    bids = Contract.all.map(&:bid_id)
    self.where.not(id: bids)
  end

  def self.accepted_bids
    bids = Bid.where(status: "Accepted")
  end
end