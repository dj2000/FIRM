class CommissionRate < ActiveRecord::Base

	validates :scale_start, :scale_end, :title, presence: true

	validate :of_scale

	def scale
		"$#{self.scale_start} - $#{self.scale_end}"
	end

	def of_scale
		if self.scale_start and self.scale_end
			self.errors.add(:scale_end, "Scale end can't be less than scale start.") if self.scale_start >= self.scale_end
		end
	end
end
