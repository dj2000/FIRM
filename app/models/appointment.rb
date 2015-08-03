class Appointment < ActiveRecord::Base
  belongs_to :svc_area
  belongs_to :svc_criterium
  belongs_to :insp_request, class_name: 'InspRequest', foreign_key: 'inspRequest_id'
  belongs_to :inspector
  has_one :inspection

  PAYMENT_METHOD = ["Cash", "Check", "Credit Card", "Mailing", "Inspector"]

  validates :inspFee, presence: true
end
