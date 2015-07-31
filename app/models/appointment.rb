class Appointment < ActiveRecord::Base
  belongs_to :svc_area
  belongs_to :svc_criterium
  belongs_to :insp_request, class_name: 'InspRequest'
  belongs_to :inspector
  has_one :inspection
end
