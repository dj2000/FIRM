class Bid < ActiveRecord::Base
  belongs_to :inspection
  has_many :pay_plans
end
