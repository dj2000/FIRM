class Inspector < ActiveRecord::Base
  has_many :appointments
  has_many :insp_skills
  has_many :insp_comm_scales
end
