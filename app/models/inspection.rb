class Inspection < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :inspector
  has_many :bids
  has_many :comm_histories
  has_many :invoices

  accepts_nested_attributes_for :bids, allow_destroy: true, reject_if: proc { |attributes| attributes['costRepair'].blank? || attributes['feeSeismicUpg'].blank? || attributes['feeAdmin'].blank? }

  validates :fCondition, :footprintURL, :name, presence: true

  has_attached_file :report

  validates_attachment_content_type :report, :content_type => %w( application/msword application/pdf application/vnd.openxmlformats-officedocument.wordprocessingml.document )

  FOUNDATION_CONDITION = ["Repair Needed", "No Repair Needed"]

  def humanize(attribute)
		self.send("#{attribute}") ? "Yes" : "No"
  end
end