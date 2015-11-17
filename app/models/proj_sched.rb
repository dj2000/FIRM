class ProjSched < ActiveRecord::Base
  belongs_to :project
  belongs_to :crew

  validates :crew_id, :schedule_start_date, :schedule_end_date, :startTime, :endTime, presence: true

  validate :availability_of_crew

  validate :check_end_time, :check_project_scheduled_start_and_end_date

  COLORS = Crew.assign_colors

  def as_json
    {
      start: self.sched_start,
      end: self.sched_end,
      title: self.try(:crew).try(:foreman),
      id: self.id,
      color: ProjSched::COLORS["#{self.crew_id}"],
      allDay: false,
      project: self.try(:project).try(:title)
    }
  end

  def sched_start
		"#{schedule_start_date.strftime("%Y-%m-%d")} #{startTime.strftime("%I:%M %p")}".to_datetime
  end

  def sched_end
		"#{schedule_end_date.strftime("%Y-%m-%d")} #{endTime.strftime("%I:%M %p")}".to_datetime
  end

  def schedule_date
    "#{schedule_start_date.try(:strftime, "%d %b %Y")} to #{schedule_end_date.try(:strftime, "%d %b %Y")}"
  end

  private

  def availability_of_crew
		double_book = (self.crew_id and self.try(:crew).try(:double_book?))
		start_time = self.startTime.strftime("%H:%M:%S")
		end_time = self.endTime.strftime("%H:%M:%S")
    if double_book
      crews_availability = ProjSched.where('project_id != ? AND crew_id = ? AND (((schedule_start_date BETWEEN ? AND ?) AND ("startTime" BETWEEN ? AND ?)) OR ((schedule_end_date BETWEEN ? AND ?) AND ("endTime" BETWEEN ? AND ?)))', self.project_id, self.crew_id, self.schedule_start_date, self.schedule_end_date, start_time, end_time, self.schedule_start_date, self.schedule_end_date, start_time, end_time)
      invalid_record = crews_availability.present? ? true : false
    else
      is_scheduled = ProjSched.where(crew_id: self.crew_id).where.not(id: self.id).first
      invalid_record = is_scheduled ? true : false
    end
		self.errors.add(:crew_id, "Crew is not available for this time slot.") if invalid_record
  end

  def check_end_time
    if self.startTime.present? and self.endTime.present?
      self.errors.add(:endTime, "Schedule End time should be greater than Schedule Start time.") if self.startTime > self.endTime
    end
  end

  ## Validation check for start and end date while scheduling project with project's scheduled start and end date.
  def check_project_scheduled_start_and_end_date
    start_date = self.try(:project).try(:scheduleStart)
    end_date = self.try(:project).try(:scheduleEnd)
    self.errors.add(:base, "Please select scheduled start date or scheduled end date.") unless start_date || end_date
    if start_date and end_date
      date_range = (start_date..end_date)
      unless date_range.include?(self.schedule_start_date) and date_range.include?(self.schedule_end_date)
        self.errors.add(:base, "Please select date range from #{start_date.strftime("%d %b %Y")} and #{end_date.strftime("%d %b %Y")}")
      end
    end
  end
end
