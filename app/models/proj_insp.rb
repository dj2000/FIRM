class ProjInsp < ActiveRecord::Base
  extend AsCSV

  belongs_to :project

  validates :project_id, :reference, :scheduleDate, :inspectBy, :completeDate, presence: true

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Project", "Reference", "Scheduled Date", "Inspected By", "Completed Date", "Result"]
      all.each do |proj_insp|
        row = [
                proj_insp.try(:project).try(:title),
                proj_insp.reference,
                proj_insp.try(:scheduleDate).try(:strftime, "%d %b %Y"),
                proj_insp.try(:inspectBy),
                proj_insp.try(:completeDate).try(:strftime, "%d %b %Y"),
                proj_insp.result
              ]
        csv << row
      end
    end
  end
end
