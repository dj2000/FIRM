class BlockOutPeriod < ActiveRecord::Base
	belongs_to :inspector

  validates :schedStart, :schedEnd, :inspector_id, presence: true

  validate :check_end_datetime

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
end
