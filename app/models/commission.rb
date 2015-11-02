class Commission < ActiveRecord::Base
	belongs_to :inspector
	belongs_to :commission_rate
	validates :inspector_id, :commission_rate_id, :percentage, presence: true
	validates_uniqueness_of :inspector_id, scope: :commission_rate_id

	def scale
		commission_rate = self.commission_rate
		(commission_rate.scale_start..commission_rate.scale_end)
	end
end
