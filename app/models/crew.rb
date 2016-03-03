class Crew < ActiveRecord::Base
  extend AsCSV

  has_many :projects, dependent: :destroy
  has_many :crew_skills, dependent: :destroy

  validates :foreman, :size, presence: true

  validates :email, email_format: { message: "Invalid Email Address" }

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

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Foreman", "Size", "Doublebook", "Notes"]
      all.each do |crew|
        row = [
                crew.foreman,
                crew.size,
                crew.is_double_book,
                crew.notes
              ]
        csv << row
      end
    end
  end
end
