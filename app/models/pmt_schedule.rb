class PmtSchedule < ActiveRecord::Base
  extend AsCSV

  belongs_to :contract
end
