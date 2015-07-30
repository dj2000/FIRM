class Property < ActiveRecord::Base
  has_many :client_properties
  has_many :clients, through: :client_properties
  has_many :insp_requests

  OCCUPIED_BY = %w(Rented Owner Occupied Vacant)

  LOT_TYPE = %w(Hill Flat Slope)

  FOUNDATION = %w(Raised Slab Other)

  PROPERTY_TYPE = %w(SFR MFR)

  YEAR_BUILT = (1965..Date.current.year)

  validates :street, :city, :state, :zip, presence: true

  def property_select_value
  	"#{number} #{street}, #{city}, #{state} #{zip}"
  end
  
end