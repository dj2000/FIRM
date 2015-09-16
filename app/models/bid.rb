class Bid < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :payPlan
  has_one :comm_history

  validates :costRepair, :feeSeismicUpg, :feeAdmin, :inspection_id, :title, presence: true

  before_create :default_status

  # Set default status as pending
  def default_status
		self.status = "Pending"
  end
end