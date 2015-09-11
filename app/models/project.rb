class Project < ActiveRecord::Base

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
  validates_presence_of :contract_id, :jobCost, :scheduleBy, :estDuration, :authorizedBy, :authorizedOn, :title, :schedule_pref_start, :schedule_pref_end

  validates_presence_of :crew_id, :scheduleStart, :scheduleEnd, if: "crew_schedule.present?"

  def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end
end
