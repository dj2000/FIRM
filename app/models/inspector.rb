class Inspector < ActiveRecord::Base
  has_many :appointments
  has_many :insp_skills
  has_many :insp_comm_scales
  validates :firstName, :lastName, :senior, presence: true
  validates :phoneH, :phoneC,
							numericality: true,
							length: { :minimum => 10, :maximum => 15 },
							allow_blank: true

  validates :email, email_format: { message: "Invalid Email Address" }, allow_blank: true
  validates :zip,
              length:
                { is: 5,
                  allow_blank: true }

  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end
end
