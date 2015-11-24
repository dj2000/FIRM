class CommissionRate < ActiveRecord::Base
  extend AsCSV

	validates :scale_start, :title, presence: true

	validate :of_scale, :is_overlapped

	after_save :set_scale_end

	def scale
		"$#{self.scale_start} - $#{self.scale_end}"
	end

	def of_scale
		if self.scale_start and self.scale_end
			self.errors.add(:scale_end, "Scale end can't be less than scale start.") if self.scale_start >= self.scale_end
		end
	end

	def is_overlapped
		commission_rates = CommissionRate.where("(scale_start BETWEEN (?) AND (?) ) OR (scale_end BETWEEN (?) AND (?) )", self.scale_start, self.scale_end, self.scale_start, self.scale_end).where.not(id: self.id)
		overlapped = commission_rates.present? ? true : false
		self.errors.add(:base, "Overlapping of scales.") if overlapped
	end

	def commission_rate_select
		"#{self.title} (#{self.scale})"
	end

	def as_json
		{ start: scale_start, end: scale_end, record: self }
	end

	def set_scale_end
		max_commission_rate = CommissionRate.where(scale_end: nil).where.not(id: self.id).first
		if max_commission_rate.present?
			last_commission_rate = max_commission_rate
		else
			max_commission_rate = CommissionRate.where("scale_end <= ? ", self.scale_start).maximum("scale_end")
			last_commission_rate = CommissionRate.where(scale_end: max_commission_rate).first
		end
		last_commission_rate.update(scale_end: self.scale_start - 1) if last_commission_rate
	end

	def self.as_csv
    CSV.generate do |csv|
      csv << ["Level", "Scale"]
      all.each do |commission_rate|
        row = [
                commission_rate.title,
								commission_rate.scale
              ]
        csv << row
      end
    end
  end
end
