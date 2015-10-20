class Inspection < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :inspector
  has_many :bids
  has_many :comm_histories
  has_many :invoices
  has_many :documents, as: :attachable

  accepts_nested_attributes_for :bids, allow_destroy: true, reject_if: proc { |attributes| attributes['costRepair'].blank? || attributes['feeSeismicUpg'].blank? || attributes['feeAdmin'].blank? }

  accepts_nested_attributes_for :documents, reject_if: proc { |attributes| attributes['attachment'].blank? }, allow_destroy: true

  validates :fCondition, :name, presence: true

  has_attached_file :report
  has_attached_file :completed_appointment_sheet
  has_attached_file :client_information_sheet
  has_attached_file :footprint_diagram

  validates_attachment_content_type :completed_appointment_sheet, content_type: ["image/jpg", "image/png", "application/pdf"]
  validates_attachment_content_type :report, content_type: %w( application/msword application/pdf application/vnd.openxmlformats-officedocument.wordprocessingml.document )
  validates_attachment_content_type :client_information_sheet, content_type: ["image/jpg", "image/png", "application/pdf"]
  validates_attachment_content_type :footprint_diagram, content_type: ["image/jpg", "image/png", "application/pdf"]

  FOUNDATION_CONDITION = ["Repair Needed", "No Repair Needed"]

  def humanize(attribute)
		self.send("#{attribute}") ? "Yes" : "No"
  end
end