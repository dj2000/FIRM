class Bid < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :payPlan

  validates :costRepair, :feeSeismicUpg, :feeAdmin, :inspection_id, presence: true

  before_create :default_status

  # Set default status as pending
  def default_status
		self.status = "Pending"
  end
end