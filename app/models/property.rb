class Property < ActiveRecord::Base
  has_many :client_properties, dependent: :destroy
  has_many :clients, through: :client_properties, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  OCCUPIED_BY = %w(Rented Owner Occupied Vacant)

  LOT_TYPE = %w(Hill Flat Slope)

  FOUNDATION = %w(Raised Slab Other)

  PROPERTY_TYPE = %w(SFR MFR)

  YEAR_BUILT = (1965..Date.current.year)

  validates :street, :city, :state, presence: true

  validates :zip,
              presence: true,
              length:
                { is: 5,
                  allow_blank: true }


  def property_select_value
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
    "#{number} #{street}, #{city}, #{state_name} #{zip}"
  end
  
  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end
end