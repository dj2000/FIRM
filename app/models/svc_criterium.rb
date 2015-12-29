class SvcCriterium < ActiveRecord::Base
  extend AsCSV

  has_many :appointments, dependent: :destroy

  DEFAULTS = { "True" => "1", "False" => "0", "Ignore" => "2" }

  YEAR_BUILT = (1901..Date.today.year)

  validates :yearBuilt, :prevInsp, :hpoz, :cdo, :ownerOcc, presence: true

  validates :foundation, uniqueness: true, presence: true

  validates :propRes, uniqueness: { scope: :propComm }

  def property_type
    self.propRes? ? "Residential" : "Commercial"
  end

  def humanize(attribute)
    SvcCriterium::DEFAULTS.key(self.send("#{attribute}").to_s)
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << ["Property Type", "Previously Inspected", "Historical Property Overlay Zone(HPOZ)", "Community Design Overlay(CDO)", "Owner Occupied", "Foundation Type", "Construction Year", "Notes"]
      all.each do |svc_criterium|
        row = [
                svc_criterium.property_type,
                svc_criterium.humanize("prevInsp"),
                svc_criterium.humanize("hpoz"),
                svc_criterium.humanize("cdo"),
                svc_criterium.humanize("ownerOcc"),
                svc_criterium.foundation,
                svc_criterium.yearBuilt,
                svc_criterium.notes
              ]
        csv << row
      end
    end
  end
end
