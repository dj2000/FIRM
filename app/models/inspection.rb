class Inspection < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :inspector
  has_many :bids
  has_many :comm_histories
  has_many :invoices

  validates :fCondition, :footprintURL, presence: true

  has_attached_file :report

  FOUNDATION_CONDITION = ["Repair Needed", "No Repair Needed"]

  def humanize(attribute)
		self.send("#{attribute}") ? "Yes" : "No"
  end
end