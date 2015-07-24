class InspSkill < ActiveRecord::Base
  belongs_to :inspector
  belongs_to :skill
end
