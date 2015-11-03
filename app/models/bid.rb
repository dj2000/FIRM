class Bid < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :payPlan
  has_many :comm_histories

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

  def calculate_amount(percentage_amount, cost = nil)
    cost = cost ? cost : self.total_cost
    ((cost.to_f * percentage_amount.to_f) / 100).to_f if cost > 0.0
  end

  def self.uncontracted_bids
    bids = Contract.all.map(&:bid_id)
    self.where.not(id: bids)
  end
end