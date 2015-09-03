class Bid < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :payPlan

  validates :costRepair, :feeSeismicUpg, :feeAdmin, :inspection_id, presence: true
end
