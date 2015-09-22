class Receipt < ActiveRecord::Base
  belongs_to :invoice

  validates :reference, :date, :invoice_id, :amount, presence: true
end
