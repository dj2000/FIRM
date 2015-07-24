class Property < ActiveRecord::Base
  has_many :client_properties
  has_many :clients, through: :client_properties
  has_many :insp_requests
end