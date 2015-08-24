class Inspection < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :inspector
  has_many :bids
  has_many :comm_histories
  has_many :invoices

  def humanize(attribute)
		self.send("#{attribute}") ? "Yes" : "No"
  end
end