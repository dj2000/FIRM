class Property < ActiveRecord::Base
  extend AsCSV
  has_many :client_properties, dependent: :destroy
  has_many :clients, through: :client_properties, dependent: :destroy
  has_many :insp_requests, dependent: :destroy

  OCCUPIED_BY = %w(Rented Owner Vacant Other)

  LOT_TYPE = %w(Hill Flat Slope)

  FOUNDATION = %w(Raised Slab)

  PROPERTY_TYPE = %w(SFR MFR)

  validates :street, :city, :state, presence: true

  validates :zip,
              presence: true,
              length:
                { is: 5,
                  allow_blank: true }

  before_save :set_default_year_built

  geocoded_by :address

  after_validation :geocode, if: Proc.new{|p| p.city_changed? or p.state_changed? or p.street_changed? or p.zip_changed? }

  #To populate select dropdown
  def property_select_value
    "#{number} #{street}, #{city}, #{state_name} #{zip}"
  end

  #For getting full name of state
  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end

  def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end

  def address
    "#{street}, #{city}, #{state}, #{zip}"
  end

  # To show Selected value of occupied by field on form
  def occupied
    return nil if self.occupied_by.nil?
    occupied_by = (Property::OCCUPIED_BY.first(3)).include?(self.occupied_by) ? self.occupied_by : "Other"
  end

  # For setting default year built
  def set_default_year_built
    self.yearBuilt = 1965 if self.yearBuilt.blank?
  end

  def calculate_latitude_and_longitude
    latitude, longitude = Geocoder::Calculations.extract_coordinates(self.try(:address))
    { lat: latitude, long: longitude }
  end


  def self.as_csv
    CSV.generate do |csv|
      csv << ["Number", "street", "City", "State", "Zip", "Year Built", "Size in Square Footage", "Number of floor levels", "Building Type","Number of Units", "Lot Type","Foundation Type","Occupied By"]
      all.each do |property|
        row = [
                 property.number,
                 property.city,
                 property.street,
                 property.state_name,
                 property.zip,
                 property.yearBuilt,
                 property.size,
                 property.stories,
                 property.prop_type,
                 property.units,
                 property.lotType,
                 property.foundation,
                 property.occupied_by
              ]
        csv << row
      end
    end
  end

end
