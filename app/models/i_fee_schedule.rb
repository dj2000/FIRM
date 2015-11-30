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

	def self.as_csv
    CSV.generate do |csv|
      csv << ["Effective From", "Status", "Owner Occupied Rate", "SFR Base Rate", "SFR Increment Rate", "MFR Base Rate", "MFR Increment Rate", "INS Base Rate", "INS Increment Rate"]
      all.each do |fee_schedule|
        row = [
                fee_schedule.effective_from,
								fee_schedule.status,
								fee_schedule.ownerOccRate,
								fee_schedule.sfrBaseRate ,
								fee_schedule.sfrIncRate,
								fee_schedule.mfrBaseRate,
								fee_schedule.mfrIncRate,
								fee_schedule.insBaseRate,
								fee_schedule.insIncRate
              ]
        csv << row
      end
    end
  end
end
