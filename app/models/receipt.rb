class Receipt < ActiveRecord::Base
  belongs_to :invoice
end
