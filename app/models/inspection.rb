class Inspection < ActiveRecord::Base
  extend AsCSV
  belongs_to :appointment
  belongs_to :inspector
  has_many :bids, -> { order 'bids.created_at' }
  has_many :comm_histories
  has_many :invoices
  has_many :documents, as: :attachable

  accepts_nested_attributes_for :bids, allow_destroy: true, reject_if: proc { |attributes| attributes['costRepair'].blank? || attributes['feeSeismicUpg'].blank? || attributes['feeAdmin'].blank? }

  validates :fCondition, :name, presence: true

  has_attached_file :report
  has_attached_file :completed_appointment_sheet
  has_attached_file :client_information_sheet
  has_attached_file :footprint_diagram

  validates_attachment_content_type :completed_appointment_sheet, content_type: ["image/jpg", "image/png", "application/pdf"]
  validates_attachment_content_type :report, content_type: %w( application/msword application/pdf application/vnd.openxmlformats-officedocument.wordprocessingml.document )
  validates_attachment_content_type :client_information_sheet, content_type: ["image/jpg", "image/png", "application/pdf"]
  validates_attachment_content_type :footprint_diagram, content_type: ["image/jpg", "image/png", "application/pdf"]

  FOUNDATION_CONDITION = ["No report wanted", "No bid, no work", "Bid provided", "Report ONLY (no bid)"]

  def humanize(attribute)
		self.send("#{attribute}") ? "Yes" : "No"
  end

  def self.created_between(start_date, end_date)
    Inspection.joins(:appointment).
      where('("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)',
      start_date, end_date, start_date, end_date)
  end
end