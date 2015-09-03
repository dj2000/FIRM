class CommHistory < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :bid

  validates :caller, :recipient, :callSummary, :notes, presence: true
end
