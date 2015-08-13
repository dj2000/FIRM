class Property < ActiveRecord::Base
  has_many :client_properties, dependent: :destroy
  has_many :clients, through: :client_properties, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  OCCUPIED_BY = %w(Rented Owner Occupied Vacant)

  LOT_TYPE = %w(Hill Flat Slope)

  FOUNDATION = %w(Raised Slab Other)

  PROPERTY_TYPE = %w(SFR MFR)

  YEAR_BUILT = (1901..1965)

  validates :street, :city, :state, presence: true

  validates :zip,
              presence: true,
              length:
                { is: 5,
                  allow_blank: true }

  before_save :set_default_year_built

  #To populate select dropdown
  def property_select_value
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
    "#{number} #{street}, #{city}, #{state_name} #{zip}"
  end

  #For getting full name of state
  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end

  def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end

  # For setting default year built
  def set_default_year_built
    self.yearBuilt = 1965 if self.yearBuilt.blank?
  end
end