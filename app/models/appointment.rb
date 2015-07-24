class Appointment < ActiveRecord::Base
  belongs_to :svc_area
  belongs_to :svc_criterium
  belongs_to :insp_request
  belongs_to :inspector
  has_one :inspection
end
