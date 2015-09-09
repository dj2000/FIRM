class Contract < ActiveRecord::Base
  belongs_to :bid
  has_one :commission
  has_one :project
  has_many :pmt_schedules

  attr_accessor :accepted, :signed, :down_payment

  validates :bid_id, :date, presence: true

  validates :acceptedBy, :accepted_date, presence: true, if: Proc.new { |a| a.accepted == "1" }

	validates :dateSigned, :signedBy, presence: true, if: Proc.new { |a| a.signed == "1" }

	validates :downPmtDate, :downPmtAmt, presence: true, if: Proc.new { |a| a.down_payment == "1" }

  def accepted?(params = nil)
    (params and params[:accepted] and params[:accepted] == "1") || (self.accepted_date and self.acceptedBy)
  end

  def signed?(params = nil)
		(params and params[:signed] and params[:signed] == "1") || (self.dateSigned and self.signedBy)
  end

  def down_payment?(params = nil)
		(params and params[:down_payment] and params[:down_payment] == "1") || (self.downPmtAmt and self.downPmtDate)
  end
end
