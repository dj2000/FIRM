class InspRequest < ActiveRecord::Base
  has_one :appointment
  belongs_to :client
  belongs_to :agent
  belongs_to :property
end
