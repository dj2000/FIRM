class Project < ActiveRecord::Base

  extend AsCSV
	## Non Model Attributes
  attr_accessor :crew_schedule

	## Associations
  belongs_to :contract
  belongs_to :crew
  has_many :permits
  has_many :invoices
  has_many :proj_scheds
  has_many :proj_insps

	## Validations
  validates_presence_of :contract_id, :jobCost, :scheduleBy, :estDuration, :authorizedBy, :authorizedOn, :title, :schedule_pref_start, :schedule_pref_end, :scheduleStart, :scheduleEnd

  validates_presence_of :crew_id, :scheduleStart, :scheduleEnd, if: "crew_schedule.present?"

  validate :check_preferred_schedule_end_datetime, :check_schedule_end_date

  def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end

  def self.permitted_projects
    self.where(permit: true)
  end

  def preferred_by
    "#{self.try(:schedule_pref_start).try(:strftime, '%d %b %Y')} to #{self.try(:schedule_pref_end).try(:strftime, '%d %b %Y') }"
  end

  def scheduled
    "#{self.try(:sheduleStart).try(:strftime, '%d %b %Y')} to #{self.try(:sheduleEnd).try(:strftime, '%d %b %Y') }"
  end

  private

  def check_preferred_schedule_end_datetime
    if self.schedule_pref_start.present? and self.schedule_pref_end.present?
      self.errors.add(:schedule_pref_end, "Preferred Schedule End Date should be greater than Preferred Schedule Start Date.") if self.schedule_pref_end < self.schedule_pref_start
    end
  end

  def check_schedule_end_date
    if self.scheduleStart.present? and self.scheduleEnd.present?
      self.errors.add(:scheduleEnd, "Schedule End Date should be greater than Schedule Start Date.") if self.scheduleEnd < self.scheduleStart
    end
  end
end
