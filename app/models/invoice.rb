class Invoice < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :project
  has_many :receipts

  ## For getting client name of respective inspection or project
  def client_name
		inspection = (self.try(:inspection) || self.try(:project).try(:contract).try(:bid).try(:inspection))
		inspection.try(:appointment).try(:insp_request).try(:client)
  end

  def pay_plan
		self.try(:project).try(:contract).try(:bid).try(:payPlan)
  end
end
