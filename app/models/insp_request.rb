class InspRequest < ActiveRecord::Base
  has_one :appointment, class_name: 'Appointment', foreign_key: 'inspRequest_id'
  belongs_to :client
  belongs_to :agent
  belongs_to :property

  REFERRAL_SOURCE = %w(Internet Advertisement TV Friend Other)

  SELECTION_CRITERIA = ['Specific Inspector', 'Senior Inspector', 'Next Available']

  validates :callTime, :client_id, :property_id, :selectInsp, presence: true
  validates :client_id, uniqueness: { scope: :property_id, message: "Property has already been assigned for same customer." }

  def has_appointment?
  	self.appointment ? "Scheduled" : "Unscheduled"
  end

  def call_time
    self.try(:callTime).try(:strftime, "%d %b %Y %H:%M:%S")
  end

  def disable_client?
    self.try(:client) ? false : true
  end

  def disable_agent?
    self.try(:agent) ? false : true
  end

  def check_conditions_for_appointment
    svc_criterium = SvcCriterium.where(propRes: true).first
    property = self.try(:property)
    return true unless property_previously_inspection_check(svc_criterium, property) and foundation_check(property) and service_area_check(property)
  end

  def property_previously_inspection_check(svc_criterium, property)
    if svc_criterium.try(:prevInsp) == 0
      insp_requests = property.try(:insp_requests)
      if insp_requests
        insp_requests.each do |insp_request|
          appointment = insp_request.try(:appointment)
          return false unless appointment
          return false unless appointment.try(:inspection)
        end
      end
    end
  end

  def foundation_check(property)
    property.try(:foundation) == "Raised" or property.try(:foundation) == "Slab"
  end

  def service_area_check(property)
    service_area = SvcArea.where(zip: property.try(:zip), serviced: true).first
  end
end