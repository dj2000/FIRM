class CommHistory < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :bid

  validates :caller, :recipient, :callSummary, :notes, :bid_id, presence: true

  validate :call_back_date, if: Proc.new{|c| c.callOutcome == "CallBack" }

  def call_back_date
		self.errors.add(:callBackDate, "Call Back Date should be greater than Call Date.") unless self.callBackDate >= self.call_time
  end
end
