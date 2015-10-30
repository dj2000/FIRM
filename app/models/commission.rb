class Commission < ActiveRecord::Base
	belongs_to :inspector
	belongs_to :commission_rate
end
