class ProjSched < ActiveRecord::Base
  belongs_to :project
  belongs_to :crew

  validates :crew_id, :schedule_start_date, :schedule_end_date, :startTime, :endTime, presence: true

  def as_json
    {
      start: self.startTime,
      end: self.endTime,
      id: self.id,
      title: self.try(:inspector).try(:firstName),
      color: 'tomato',
      crew_id: self.crew_id
    }
  end
end
