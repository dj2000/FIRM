class Permit < ActiveRecord::Base
  belongs_to :project

  validates :reference, :status, :valuation, presence: true

  STATUS = %w(Pending Approved Declined)
end
