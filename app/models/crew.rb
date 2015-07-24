class Crew < ActiveRecord::Base
  has_many :projects
  has_many :crew_skills
end
