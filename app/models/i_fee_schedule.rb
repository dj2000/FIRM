class IFeeSchedule < ActiveRecord::Base
	extend AsCSV

	validates :effectiveFrom, uniqueness: true, presence: true

	validates :ownerOccRate, :sfrBaseRate, :sfrIncRate, :mfrBaseRate, :mfrIncRate, :insBaseRate, :insIncRate, presence: true

	validate :update_status, if: "feeActive_changed? and feeActive?"

	def status
		self.feeActive? ? "Active" : "Inactive"
	end

	def effective_from
		self.effectiveFrom.try(:strftime, "%d %b %Y")
	end

	private

	#Callback for making all fee schedules inactive other than current fee schedule
	def update_status
		IFeeSchedule.where(feeActive: true).where.not(id: self.id).update_all(feeActive: false)
	end
end
