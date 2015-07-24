class Skill < ActiveRecord::Base
  has_many :insp_skills
  has_many :crew_skills
end
