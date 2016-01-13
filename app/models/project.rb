class Project < ActiveRecord::Base

  extend AsCSV
	## Non Model Attributes
  attr_accessor :crew_schedule

	## Associations
  belongs_to :contract
  belongs_to :crew
  has_many :permits, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :proj_scheds, dependent: :destroy
  has_many :proj_insps, dependent: :destroy
  belongs_to :primary_crew, class_name: "Crew", foreign_key: :primary_crew_id
  has_many :documents, as: :attachable, dependent: :destroy

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

  private

  def check_schedule_end_date
    if self.scheduleStart.present? and self.scheduleEnd.present?
      self.errors.add(:scheduleEnd, "Schedule End Date should be greater than Schedule Start Date.") if self.scheduleEnd < self.scheduleStart
    end
  end
end



