class CreditNote < ActiveRecord::Base
	belongs_to :invoice
  validates :reference, :date, :invoice_id, :amount, presence: true
  validate :check_invoice_amount

  attr_accessor :invoice_amount

  after_save :update_invoice_balance, if: "self.amount_changed?"

  def update_invoice_balance
    amount_values = self.amount_change.map(&:to_f)
    new_amount = amount_values.last
    prev_amount = amount_values.first
    if new_amount > prev_amount
      difference_amount = new_amount - prev_amount
      invoice_amount = invoice.try(:amount).try(:to_f) - difference_amount.to_f
    elsif new_amount < prev_amount
      difference_amount = prev_amount - new_amount
      invoice_amount = invoice.try(:amount).try(:to_f) + difference_amount.to_f
    end
    invoice = self.try(:invoice)
    invoice.update_attributes(amount: invoice_amount)
  end

  def check_invoice_amount
    self.errors.add(:amount, "Amount can not be greater than Invoice Amount.") if (self.invoice_amount and self.amount and self.invoice_amount.to_f < self.amount)
  end
end
