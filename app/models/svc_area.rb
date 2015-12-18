class SvcArea < ActiveRecord::Base
  extend AsCSV

  has_many :appointments, dependent: :destroy
  validates :city, :state, presence: true

  validates :zip,
              presence: true,
              uniqueness: true,
              length:
                { is: 5,
                  allow_blank: true }

  #For getting full name of state
  def state_name
    state_name = CS.states(:us)[ self.try(:state).try(:to_sym) ]
  end

  def is_serviced
    self.serviced? ? "Yes" : "No"
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["State", "City", "Zip", "Serviced", "Notes"]
      all.each do |svc_area|
        row = [
                svc_area.state_name,
                svc_area.city,
                svc_area.zip,
                svc_area.is_serviced,
                svc_area.notes
              ]
        csv << row
      end
    end
  end
end

