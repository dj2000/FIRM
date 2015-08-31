class Bid < ActiveRecord::Base
  belongs_to :inspection
  has_many :pay_plans

  validates :costRepair, :feeSeismicUpg, :feeAdmin, :inspection_id, presence: true
end
