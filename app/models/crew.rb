class Crew < ActiveRecord::Base
  extend AsCSV

  has_many :projects
  has_many :crew_skills

  validates :foreman, :size, presence: true

  def is_double_book
		self.double_book? ? "Yes" : "No"
  end

  ## For assigning colors as per crew id
  def self.assign_colors
    colors = {}
    crew_ids = self.all.map(&:id)
    crew_ids.each do |crew_id|
      colors["#{crew_id}"] = "##{rand(0xffffff).to_s(16)}"
    end
    colors
  end
end
