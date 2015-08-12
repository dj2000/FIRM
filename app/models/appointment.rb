class Appointment < ActiveRecord::Base
  belongs_to :svc_area
  belongs_to :svc_criterium
  belongs_to :insp_request, class_name: 'InspRequest', foreign_key: 'inspRequest_id'
  belongs_to :inspector
  has_one :inspection

  attr_accessor :scheduled_inspection

  PAYMENT_METHOD = ["Cash", "Check", "Credit Card", "Mailing", "Inspector"]

  validates :inspFee, 
  						presence: true,
              numericality: {
                greater_than_or_equal_to: 0.0
                },
              if: "scheduled_inspection.blank?"

  validates :amount_received,
  						numericality: {
  							greater_than_or_equal_to: 0.0
  							},
              if: "scheduled_inspection.blank?"

  validates :schedStart, :schedEnd, :inspector_id, presence: true, if: "scheduled_inspection.present?"

  validate :is_scheduled, if: "scheduled_inspection.blank?"

  validate :check_end_datetime, if: "scheduled_inspection.present?"

  def as_json
    {
      start: self.schedStart,
      end: self.schedEnd,
      id: self.id,
      title: self.try(:inspector).try(:firstName),
      color: 'tomato',
      inspector_id: self.inspector_id,
      allDay: self.allDay || false
    }
  end

  def is_prepaid
    self.try(:prepaid) ? "Yes" : "No"
  end

  def empty?
    self.new_record? || self.attributes.values.blank?
  end

  private

  def check_end_datetime
    if self.schedStart.present? and self.schedEnd.present?
      self.errors.add(:base, "Schedule End time should be greater than Schedule Start time.") if self.schedEnd < self.schedStart
    end
  end

  def is_scheduled
    if self.schedStart.blank? and self.schedEnd.blank?
      self.errors.add(:base, "Schedule appointment before continuing.")
    end
  end

end
