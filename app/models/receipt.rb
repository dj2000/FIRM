class Receipt < ActiveRecord::Base
  belongs_to :invoice
  validates :reference, :date, :invoice_id, :amount, presence: true

  after_save :update_invoice_balance

  def update_invoice_balance
		invoice = self.try(:invoice)
		invoice_amount = invoice.try(:amount).try(:to_f) - self.try(:amount).try(:to_f)
		invoice.update_attributes(amount: invoice_amount)
  end
end
