class SvcArea < ActiveRecord::Base
  has_many :appointments
  validates :city, :state, :serviced, presence: true

  validates :zip,
              presence: true,
              uniqueness: true,
              length:
                { is: 5,
                  allow_blank: true }

  #For getting full name of state
  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end

  def is_serviced
    self.serviced? ? "Yes" : "No"
  end

end
