class PayPlan < ActiveRecord::Base
  belongs_to :bid

  has_many :payments, dependent: :destroy

  accepts_nested_attributes_for :payments, reject_if: proc { |attributes| attributes['title'].blank? || attributes['value'].to_i <= 0 }, allow_destroy: true

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
		payments_total = self.try(:payments).map(&:value).sum
		total = payments_total + self.deposit if deposit
		errors.add(:base, "All payment percentages total should be 100.") unless total == 100.0
  end

  def amount
		errors.add(:jobMinAmt, "Amount Range End should be greater than Amount Range Start.") if self.jobMaxAmt < self.jobMinAmt
  end

  def payment_plan_select
		"$#{self.jobMinAmt} - $#{self.jobMaxAmt}"
  end
end
