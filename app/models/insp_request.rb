class InspRequest < ActiveRecord::Base
  has_one :appointment, class_name: 'Appointment', foreign_key: 'inspRequest_id'
  belongs_to :client
  belongs_to :agent
  belongs_to :property

  REFERRAL_SOURCE = %w(Internet Advertisement TV Friend Other)

  validates :callTime, :client_id, :property_id, presence: true
  validates :client_id, uniqueness: { scope: :property_id, message: "Property has already been assigned for same customer." }

  def has_appointment?
  	self.appointment ? "Scheduled" : "Unscheduled"
  end

  def call_time
    self.callTime.strftime("%d %b %Y %H:%M:%S")
  end
end