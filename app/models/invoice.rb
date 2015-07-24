class Invoice < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :project
  has_many :receipts
end
