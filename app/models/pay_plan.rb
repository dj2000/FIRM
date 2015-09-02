class PayPlan < ActiveRecord::Base
  belongs_to :bid

  validates :pmt1Pcnt, :pmt2Pcnt, :pmt3Pcnt, :jobMinAmt, :pmt1Desc, :pmt2Desc, :pmt3Desc, presence: true

  validates :jobMaxAmt,
							presence: true,
							numericality: {
								less_than_or_equal_to: 10000,
								allow_blank: true,
								only_integer: false
								}

  validate :calculate_final

  validate :amount

  def calculate_final
		total = 0
		[:pmt1Pcnt, :pmt2Pcnt, :pmt3Pcnt, :pmt4Pcnt, :pmt5Pcnt, :deposit].each do |col|
			total += self.send(col) unless self.send(col).blank?
		end
		errors.add(:base, "All payment percentages total should be 100.") unless total == 100.0
  end

  def amount
		errors.add(:jobMinAmt, "Amount Range End should be greater than Amount Range Start.") if self.jobMaxAmt < self.jobMinAmt
  end
end
