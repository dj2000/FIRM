class CommHistory < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :bid

  validates :caller, :recipient, :callSummary, :notes, :bid_id, presence: true

  validates :callBackDate, presence: true, if: Proc.new{|c| c.callOutcome == "Follow-up" }

  validate :call_back_date, if: Proc.new{|c| c.callOutcome == "Follow-up" }

  def call_back_date
		if self.call_time and self.callBackDate
			self.errors.add(:callBackDate, "Call Back Date should be greater than Call Date.") unless self.callBackDate >= self.call_time
		end
  end
end
