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
  							greater_than_or_equal_to: 0,
  							less_than_or_equal_to: 100
  							}

  validates :amount_received,
  						numericality: {
  							greater_than_or_equal_to: 0,
  							less_than_or_equal_to: 100
  							}

  validates :schedStart, :schedEnd, presence: true, if: "scheduled_inspection.present?"

  validate :is_scheduled, if: "scheduled_inspection.blank?"

  private

  def is_scheduled
    if self.schedStart.blank? and self.schedEnd.blank?
      self.errors.add(:base, "Schedule appointment before continuing.")
    end
  end

end
