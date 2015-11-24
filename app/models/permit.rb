class Permit < ActiveRecord::Base
  extend AsCSV

  belongs_to :project

  validates :reference, :status, :valuation, presence: true

  STATUS = %w(Pending Approved Declined)

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Project", "Reference", "Issue Date", "Issued By", "Status", "Valuation"]
      all.each do |permit|
        row = [
                permit.try(:project).try(:title),
                permit.reference,
                permit.try(:issueDate).try(:strftime, "%d %b %Y"),
                permit.issuedBy,
                permit.status ,
                permit.valuation
              ]
        csv << row
      end
    end
  end
end
