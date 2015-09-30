class ProjSched < ActiveRecord::Base
  belongs_to :project
  belongs_to :crew

  validates :crew_id, :schedule_start_date, :schedule_end_date, :startTime, :endTime, presence: true

  validate :availability_of_crew

  validate :check_end_time

  COLORS = Crew.assign_colors

  def as_json
    {
      start: self.sched_start,
      end: self.sched_end,
      title: self.try(:crew).try(:foreman),
      id: self.id,
      color: ProjSched::COLORS["#{self.crew_id}"],
      allDay: false,
      project: self.project.title
    }
  end

  def sched_start
		"#{schedule_start_date.strftime("%Y-%m-%d")} #{startTime.strftime("%I:%M %p")}".to_datetime
  end

  def sched_end
		"#{schedule_end_date.strftime("%Y-%m-%d")} #{endTime.strftime("%I:%M %p")}".to_datetime
  end

  private

  def availability_of_crew
		double_book = (self.crew_id and self.try(:crew).try(:double_book?))
		start_time = self.startTime.strftime("%H:%M:%S")
		end_time = self.endTime.strftime("%H:%M:%S")
    if double_book
      crews_availability = ProjSched.where('crew_id = ? AND (((schedule_start_date BETWEEN ? AND ?) AND ("startTime" BETWEEN ? AND ?)) OR ((schedule_end_date BETWEEN ? AND ?) AND ("endTime" BETWEEN ? AND ?)))', self.crew_id, self.schedule_start_date, self.schedule_end_date, start_time, end_time, self.schedule_start_date, self.schedule_end_date, start_time, end_time)
      invalid_record = crews_availability.present? ? true : false
    else
      is_scheduled = ProjSched.where(crew_id: self.crew_id).first
      invalid_record = is_scheduled ? true : false
    end
		self.errors.add(:crew_id, "Crew is not available for this time slot.") if invalid_record
  end

  def check_end_time
    if self.startTime.present? and self.endTime.present?
      self.errors.add(:endTime, "Schedule End time should be greater than Schedule Start time.") if self.startTime > self.endTime
    end
  end
end
