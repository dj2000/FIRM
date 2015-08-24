class Crew < ActiveRecord::Base
  has_many :projects
  has_many :crew_skills

  validates :foreman, :size, presence: true

  def is_double_book
		self.double_book? ? "Yes" : "No"
  end
end
