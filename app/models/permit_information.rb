class PermitInformation < ActiveRecord::Base
	belongs_to :project
	belongs_to :engineer

	TYPES_OF_REPLACEMENT = ["Full", "Partial"]

	validates :valuation, presence: true
	validates :type_of_replacement, presence: true, if: Proc.new { |p| p.replacement? }
	validates :amount, presence: true, if: Proc.new { |p| p.type_of_replacement == "Partial" }
	validates :engineer_id, presence: true, if: Proc.new { |p| p.engineering? }

	def humanize(attribute)
    self.send("#{attribute}") ? "Yes" : "No"
  end
end
