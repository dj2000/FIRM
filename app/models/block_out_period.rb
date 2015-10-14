class BlockOutPeriod < ActiveRecord::Base
	belongs_to :appointment
	belongs_to :inspector

  validates :schedStart, :schedEnd, :inspector_id, :appointment_id, presence: true

  validate :check_end_datetime, :check_inspector

	def as_json
    {
      start: self.schedStart,
      end: self.schedEnd,
      id: self.id,
      title: self.try(:inspector).try(:name),
      color: 'black',
      inspector_id: self.inspector_id,
      allDay: false,
      type: 'block_out_period'
    }
  end

  private

  def check_end_datetime
    if self.schedStart.present? and self.schedEnd.present?
      self.errors.add(:base, "Schedule End time should be greater than Schedule Start time.") if self.schedEnd < self.schedStart
    end
  end

  def check_inspector
    if self.appointment_id and (self.appointment.inspector_id == self.inspector_id and self.appointment_id == self.appointment_id)
      self.errors.add(:inspector_id, "Can't schedule for block out period.")
    end
  end
end
