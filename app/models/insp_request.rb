class InspRequest < ActiveRecord::Base
  has_one :appointment, class_name: 'Appointment', foreign_key: 'inspRequest_id'
  belongs_to :client
  belongs_to :agent
  belongs_to :property

  REFERRAL_SOURCE = ['Previous Agent', 'Agent', 'Previous Customer', 'Online', 'Google', 'Yelp', 'Angie’s List', 'Job Sign', 'Sign on Van/Truck', 'Miscellaneous']

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
    property_previously_inspection_check(svc_criterium, property) and foundation_check(property) and service_area_check(property)
  end

  def property_previously_inspection_check(svc_criterium, property)
    if svc_criterium.try(:prevInsp) == 0
      insp_requests = property.try(:insp_requests)
      if insp_requests
        insp_requests.each do |insp_request|
          appointment = insp_request.try(:appointment)
          return true unless appointment
          return true unless appointment.try(:inspection)
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

  def basic_amount(amount)
    inspection_fee = 0
    property = self.try(:property)
    property_type = property.try(:prop_type)
    if property_type
      inspection_fee += property_type == "MFR" ? (amount + (property.try(:units) || 1 ) * 25 ) : amount
      inspection_fee += ((property.try(:size) - 2000).to_f / 1000) * 25   if (property_type == "SFR" and property.size.present? and property.size > 2000 )
    end
    inspection_fee
  end

  def calculate_inspection_fee(appointment, is_insurance, format = nil)
    amount = basic_amount(150)
    amount += basic_amount(250) if (is_insurance == "true" || is_insurance == true)
    appointment.inspFee = (format.nil? and appointment.inspFee) ? appointment.inspFee : amount
  end
end