class PermitInformation < ActiveRecord::Base
	belongs_to :project
	belongs_to :engineer
	has_many :permits, dependent: :destroy

	TYPES_OF_REPLACEMENT = ["Full", "Partial"]

	#validates :valuation, presence: true
	validates :type_of_replacement, presence: true, if: Proc.new { |p| p.replacement? }
	validates :amount, presence: true, if: Proc.new { |p| p.type_of_replacement == "Partial" }
	validates :engineer_id, presence: true, if: Proc.new { |p| p.engineering? }

	def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end

  def select_value
	"#{self.try(:project).try(:title)}"
  end

  def replacment_type_value
  	self.send(:replacement) ? self.type_of_replacement : ""
  end

  def self.unpermitted_permit_informations
    permit_information_ids = Permit.all.map(&:permit_information_id)
    PermitInformation.where.not(id: permit_information_ids)
  end
end
