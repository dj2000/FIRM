class CommissionPaymentDetail < ActiveRecord::Base
	belongs_to :contract
	belongs_to :inspector
end
