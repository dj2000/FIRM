class PayPlan < ActiveRecord::Base
  belongs_to :bid

  validates :pmt1Pcnt, :pmt2Pcnt, :pmt3Pcnt, :jobMinAmt, :jobMaxAmt, presence: true

  def deposit
		total = 0
		[:pmt1Pcnt, :pmt2Pcnt, :pmt3Pcnt, :pmt4Pcnt, :pmt5Pcnt].each do |col|
			total += self.send(col) unless self.send(col).blank?
		end
		total
  end

end
