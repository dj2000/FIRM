class ProjSched < ActiveRecord::Base
  belongs_to :project
  belongs_to :crew
end
