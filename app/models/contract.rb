class Contract < ActiveRecord::Base
  belongs_to :bid
  has_one :commission
  has_one :project
  has_many :pmt_schedules
end
