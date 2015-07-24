class Project < ActiveRecord::Base
  belongs_to :contract
  belongs_to :crew
  has_many :permits
  has_many :invoices
  has_many :proj_scheds
  has_many :proj_insps
end
