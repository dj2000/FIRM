class Property < ActiveRecord::Base
  has_many :client_properties
  has_many :clients, through: :client_properties
  has_many :insp_requests

  def property_select_value
  	"#{number} #{street}, #{city}, #{state} #{zip}"
  end
  
end