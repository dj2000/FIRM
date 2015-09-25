class ProjInsp < ActiveRecord::Base
  belongs_to :project

  validates :project_id, :reference, :scheduleDate, :inspectBy, :completeDate, presence: true
end
