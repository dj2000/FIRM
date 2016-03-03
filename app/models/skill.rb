class Skill < ActiveRecord::Base
  has_many :insp_skills, dependent: :destroy
  has_many :crew_skills, dependent: :destroy
end
