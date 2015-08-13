class ClientProperty < ActiveRecord::Base
  belongs_to :client
  belongs_to :property
	validates :client_id, uniqueness: { scope: :property_id }
  validates :client_id, :property_id, presence: true

  def is_escrow
		self.try(:escrow) ? "Yes" : "No"
  end
end
