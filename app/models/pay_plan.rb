class PayPlan < ActiveRecord::Base
  extend AsCSV

  belongs_to :bid

  has_many :payments, -> { order 'payments.created_at' }, dependent: :destroy

  accepts_nested_attributes_for :payments, reject_if: proc { |attributes| attributes['title'].blank? || attributes['value'].to_i <= 0 }, allow_destroy: true

  validates :jobMinAmt, :deposit, :title, presence: true

  validates :jobMaxAmt,
							presence: true,
							numericality: {
								allow_blank: true,
								only_integer: false
								}

  validate :calculate_final

  validate :amount

  def calculate_final
		total = 0
		payments_total = self.try(:payments).map(&:value).sum
		total = payments_total + self.deposit if deposit
		errors.add(:base, "All payment percentages total should be 100.") unless total == 100.0
  end

  def amount
		errors.add(:jobMinAmt, "Amount Range End should be greater than Amount Range Start.") if self.jobMaxAmt < self.jobMinAmt
  end

  def payment_plan_select
		"#{self.title} ($#{self.jobMinAmt} - $#{self.jobMaxAmt})"
  end

  def deposit_limit_value(bid = nil)
    return 0 unless bid
    deposit_value = bid.try(:calculate_amount, self.deposit)
    return 0 if deposit_value <= self.try(:deposit_limit)
    (deposit_value - self.try(:deposit_limit))
  end

  def deposite_amount(bid)
    deposit_value = bid.try(:calculate_amount, self.deposit)
    amount = deposit_value <= self.try(:deposit_limit) ? deposit_value : self.try(:deposit_limit)
    return amount
  end

  def calculate_first_payment(bid = nil)
    first_payment = self.try(:payments).try(:first)
    return 0 unless first_payment
    deposit_limit_value = self.deposit_limit_value(bid)
    if bid
      first_payment_amount = bid.try(:calculate_amount, first_payment.try(:value))
      amount = first_payment_amount + deposit_limit_value
    end
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Title", "Amount Range Start", "Amount Range End", "Deposit"]
      all.each do |pay_plan|
        row = [
                pay_plan.title ,
                "$#{pay_plan.jobMinAmt}",
                "$#{pay_plan.jobMaxAmt}",
                "#{pay_plan.deposit}%"
              ]
        csv << row
      end
    end
  end
end