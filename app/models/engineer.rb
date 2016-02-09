class Engineer < ActiveRecord::Base
	def name
    "#{self.try(:first_name)} #{self.try(:last_name)}"
  end
end
