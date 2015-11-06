class Receipt < ActiveRecord::Base
  belongs_to :invoice
  validates :reference, :date, :invoice_id, :amount, presence: true
  validate :check_invoice_amount

  attr_accessor :invoice_amount

  after_save :update_invoice_balance, if: "self.amount_changed?"
  before_destroy :update_invoice_balance

  def update_invoice_balance
    amount_values = self.amount_change.map(&:to_f) if self.amount_changed?
    if amount_values
      new_amount = amount_values.last
      prev_amount = amount_values.first
      if new_amount > prev_amount
        difference_amount = new_amount - prev_amount
        invoice_amount = invoice.try(:amount).try(:to_f) - difference_amount.to_f
      elsif new_amount < prev_amount
        difference_amount = prev_amount - new_amount
        invoice_amount = invoice.try(:amount).try(:to_f) + difference_amount.to_f
      end
    else
      invoice_amount = invoice.try(:amount).try(:to_f) + self.amount.to_f
    end
    invoice = self.try(:invoice)
    invoice.update_attributes(amount: invoice_amount)
  end

  def check_invoice_amount
    is_valid = true
    if self.new_record?
      is_valid = false if (self.invoice_amount and self.amount and self.invoice_amount.to_f < self.amount)
    else
      total = 0
      self.try(:invoice).try(:receipts).map{|r| total += r.amount if r.id != self.id }
      total += self.amount
      is_valid = false if total > self.try(:invoice).try(:project).try(:contract).try(:balance)
    end
    self.errors.add(:amount, "Amount can not be greater than Invoice Amount.") unless is_valid
  end
end
