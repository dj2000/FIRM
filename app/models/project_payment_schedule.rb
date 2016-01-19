class ProjectPaymentSchedule < ActiveRecord::Base
	belongs_to :project
	belongs_to :payment

	PAYMENT_TYPES = ["Commencement", "OK to Pour", "Completion"]

	validates :payment_type, :payment_schedule, :invoice_date, presence: true
	validates :date_paid, presence: true, if: "paid?"

	def payment_types
		payment_types_array = ProjectPaymentSchedule::PAYMENT_TYPES
		payment_types_array << "Final Sign Off" if self.try(:project).try(:permit)
		payment_types_array.uniq.map{|v| [v, v]}
	end
end