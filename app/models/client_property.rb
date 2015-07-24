class ClientProperty < ActiveRecord::Base
  belongs_to :client
  belongs_to :property
end
