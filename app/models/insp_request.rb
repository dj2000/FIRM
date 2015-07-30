class InspRequest < ActiveRecord::Base
  has_one :appointment
  belongs_to :client
  belongs_to :agent
  belongs_to :property

  REFERRAL_SOURCE = %w(Internet Advertisement TV Friend Other)

  validates :callTime, :client_id, :property_id, presence: true
  validates :client_id, uniqueness: { scope: :property_id, message: "Property has already been assigned for same customer." }
end