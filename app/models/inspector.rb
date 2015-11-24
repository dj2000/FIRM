class Inspector < ActiveRecord::Base
  has_many :appointments
  has_many :insp_skills
  has_many :insp_comm_scales
  validates :firstName, :lastName, presence: true
  validates :phoneH, :phoneC,
							length: { :minimum => 10, :maximum => 15 },
							allow_blank: true,
              format: { with: /\A[0-9\-]+*\z/ }
  validates :email, presence: true, email_format: { message: "Invalid Email Address" }
  validates :zip,
              length:
                { is: 5,
                  allow_blank: true }

  scope :active, -> { where(is_active: true) }

  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end

  def name
    "#{self.try(:firstName)} #{self.try(:lastName)}"
  end

  def senior_inspector
    self.try(:senior) ? "Yes" : "No"
  end

  def active?
    self.try(:is_active) ? "Yes" : "No"
  end

  def self.assign_colors
    colors = {}
    inspector_ids = Inspector.all.map(&:id)
    inspector_ids.each do |inspector_id|
      colors["#{inspector_id}"] = "##{rand(0xffffff).to_s(16)}"
    end
    colors
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["First Name", "Last Name", "Middle Initial", "Senior", "Active", "Home Number", "Cell Number", "Address", "City", "State", "Zip", "email"]
      all.each do |inspector|
        row = [
                inspector.firstName,
                inspector.lastName,
                inspector.middleInit,
                inspector.senior_inspector,
                inspector.active?,
                inspector.phoneH,
                inspector.phoneC,
                inspector.address,
                inspector.city,
                inspector.state_name,
                inspector.zip,
                inspector.email
              ]
        csv << row
      end
    end
  end
end

