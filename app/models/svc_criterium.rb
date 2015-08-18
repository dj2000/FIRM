class SvcCriterium < ActiveRecord::Base
  has_many :appointments

  DEFAULTS = { "True" => "1", "False" => "0", "Ignore" => "2" }

  validates :yearBuilt, :prevInsp, :hpoz, :cdo, :ownerOcc, presence: true

  validates :foundation, uniqueness: true, presence: true

  def property_type
    self.propRes? ? "Residential" : "Commercial"
  end

  def humanize(attribute)
    SvcCriterium::DEFAULTS.key(self.send("#{attribute}").to_s)
  end
end
