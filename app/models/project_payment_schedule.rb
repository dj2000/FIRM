class ProjectPaymentSchedule < ActiveRecord::Base
	belongs_to :project
	belongs_to :payment

	attr_accessor :validation_payment_schedules

	PAYMENT_TYPES = ["Down Payment", "Commencement Payment", "14 Day Prior Payment", "2nd Day Commencement Payment", "Ok to Pour Payment", "Completion Payment", "Final Payment", "Other Payment"]

	validates :payment_type, :payment_schedule, :invoice_date, presence: true
	validates :date_paid, presence: true, if: "paid?"
	validate :project_payment_schedules_invoice_date

	def payment_types
		payment_types_array = ProjectPaymentSchedule::PAYMENT_TYPES
		payment_types_array << "Final Sign Off" if self.try(:project).try(:permit)
		payment_types_array.uniq.map{|v| [v, v]}
	end

	def project_payment_schedules_invoice_date
	  self.validation_payment_schedules.each do |index, attributes|
			attributes["amount"] = attributes["amount"].to_f
			attributes["paid"] = attributes["paid"] == "1" ? true : false
			attributes["invoice_date"] = attributes["invoice_date"].present? ? attributes["invoice_date"].to_date : nil
			attributes["date_paid"] = attributes["date_paid"].present? ? attributes["date_paid"].to_date : nil
			attributes["payment_id"] = attributes["payment_id"].to_i
			self_attributes = self.attributes
			if self.new_record?
				self_attributes =  self.attributes.except("id")
			else
				attributes[:id] = attributes[:id].to_i
			end
			if self_attributes.except("created_at", "updated_at", "project_id") == attributes.to_h
	      if index != "0"
	        prev_attribute = validation_payment_schedules[(index.to_i - 1).to_s]
	        prev_invoice_date = prev_attribute["invoice_date"]
	        if self.invoice_date.present? and prev_invoice_date.present?
	          if self.invoice_date < prev_invoice_date.to_date
	            self.errors.add(:invoice_date, "Invoice Date for #{self.payment_schedule} should not be greater than #{prev_attribute["payment_schedule"]}")
	          end
	        end
	      end
	    end
	  end
  end
end