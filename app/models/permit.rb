class Permit < ActiveRecord::Base
  extend AsCSV

  belongs_to :permit_information

  has_attached_file :attachment

  validates_attachment_content_type :attachment, content_type: ["image/jpg", "image/png", "image/jpeg"]
  validates :reference, :status, :valuation, :permit_information_id, presence: true

  STATUS = %w(Issued Pending Cancelled)

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Permit Information", "Reference", "Issue Date", "Issued By", "Status", "Valuation"]
      all.each do |permit|
        row = [
                permit.try(:permit_information).try(:select_value),
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
