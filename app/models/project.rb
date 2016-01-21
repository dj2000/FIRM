class Project < ActiveRecord::Base

  extend AsCSV
	## Non Model Attributes
  attr_accessor :crew_schedule

  validates_associated :project_payment_schedules

  scope :unclosed_projects, -> { where( ready_to_process: true, status: "Open" ) } # which are ready to process and not closed projects

	## Associations
  belongs_to :contract
  belongs_to :crew
  has_many :permits, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :proj_scheds, dependent: :destroy
  has_many :proj_insps, dependent: :destroy
  belongs_to :primary_crew, class_name: "Crew", foreign_key: :primary_crew_id
  has_many :documents, as: :attachable, dependent: :destroy
  has_many :project_payment_schedules, -> { order 'project_payment_schedules.created_at' } , dependent: :destroy

  accepts_nested_attributes_for :project_payment_schedules, reject_if: proc { |attributes| attributes['payment_schedule'].blank? }, allow_destroy: true

	## Validations
  validates_presence_of :contract_id, :jobCost, :estDuration, :authorizedBy, :authorizedOn, :title, :scheduleStart, :scheduleEnd

  validates_presence_of :crew_id, :scheduleStart, :scheduleEnd, if: "crew_schedule.present?"

  validate :check_schedule_end_date

  has_one :permit_information, dependent: :destroy

  accepts_nested_attributes_for :permit_information

  def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end

  def self.permitted_projects
    self.where(permit: true)
  end

  def total_amount
    self.try(:project_payment_schedules).map(&:amount).inject(:+) || 0
  end

  def scheduled
    "#{self.try(:scheduleStart).try(:strftime, '%d %b %Y')} to #{self.try(:scheduleEnd).try(:strftime, '%d %b %Y') }"
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Contract", "Job Cost", "Est. Duration(d)", "Schedule Start", "Schedule End", "Schedule Authorize By", "Date", "Crew", "Interior Access Verified", "Electricity and Water Verified", "Notes"]
      all.each do |project|
        row = [
                project.try(:contract).try(:title),
                project.jobCost,
                project.estDuration,
                project.try(:scheduleStart).try(:strftime, "%d %b %Y"),
                project.try(:scheduleEnd).try(:strftime, "%d %b %Y"),
                project.authorizedBy ,
                project.try(:authorizedOn).try(:strftime, "%d %b %Y"),
                project.try(:crew).try(:foreman),
                project.humanize("verifiedAccess"),
                project.humanize("verifiedEW"),
                project.notes
              ]
        csv << row
      end
    end
  end

  def ready_to_process_status
    self.ready_to_process? ? "Ready" : "Pending"
  end

  def is_closed?
    return unless self.status == "Closed"
    is_paid = self.project_payment_schedules.where(payment_type: ["Completion Payment", "Final Sign Off"], paid: true )
    return is_paid.present?
  end

  def completed?
    return true if self.project_payment_schedules.where(payment_type: "Completion Payment", paid: true ).present?
  end

  def permit_sign_off?
    return true if self.project_payment_schedules.where(payment_type: "Final Sign Off", paid: true ).present?
  end

  private

  def check_schedule_end_date
    if self.scheduleStart.present? and self.scheduleEnd.present?
      self.errors.add(:scheduleEnd, "Schedule End Date should be greater than Schedule Start Date.") if self.scheduleEnd < self.scheduleStart
    end
  end
end



