class ClientProperty < ActiveRecord::Base
  belongs_to :client
  belongs_to :property

  def is_escrow
		self.try(:escrow) ? "Yes" : "No"
  end
end
