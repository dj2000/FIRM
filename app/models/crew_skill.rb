class CrewSkill < ActiveRecord::Base
  belongs_to :crew
  belongs_to :skill
end
