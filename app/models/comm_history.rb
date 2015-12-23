class CommHistory < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :bid

  validates :caller, :recipient, :callSummary, :notes, :bid_id, :callOutcome, presence: true

  validates :callBackDate, presence: true, if: Proc.new{|c| c.callOutcome == "Follow-up" }

  validate :call_back_date, if: Proc.new{|c| c.callOutcome == "Follow-up" }

  before_destroy :update_bid_status

  def call_back_date
		if self.call_time and self.callBackDate
			self.errors.add(:callBackDate, "Call Back Date should be greater than Call Date.") unless self.callBackDate >= self.call_time
		end
  end

  def update_bid_status
    bid = self.bid
    if bid.try(:comm_histories).try(:count) == 1
      bid.update(status: "Pending")
    elsif self.callOutcome == "Verbal Close"
      bid.update(status: "Follow-up")
    end
  end

  def disabled?
    return true if self.callOutcome == "Follow-up"
    return false if (self.new_record? or (self.callOutcome != "Follow-up"))
  end
end
