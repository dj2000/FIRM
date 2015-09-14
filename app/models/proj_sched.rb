class ProjSched < ActiveRecord::Base
  belongs_to :project
  belongs_to :crew

  validates :crew_id, :schedule_start_date, :schedule_end_date, :startTime, :endTime, presence: true

  COLORS = Crew.assign_colors

  def as_json
    {
      start: self.sched_start,
      end: self.sched_end,
      title: self.try(:crew).try(:foreman),
      id: self.id,
      color: ProjSched::COLORS["#{self.crew_id}"],
      allDay: false
    }
  end

  def sched_start
		"#{schedule_start_date.strftime("%Y-%m-%d")} #{startTime.strftime("%I:%M %p")}".to_datetime
  end

  def sched_end
		"#{schedule_end_date.strftime("%Y-%m-%d")} #{endTime.strftime("%I:%M %p")}".to_datetime
  end
end
