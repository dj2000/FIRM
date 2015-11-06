require 'csv'
namespace :import_service_areas do
  task :create_service_areas => :environment do
    csv_text = File.read(Rails.root.join("public", "Service Area.csv"))
    csv = CSV.parse(csv_text, :headers => true, :header_converters => lambda { |h| h.try(:downcase) })
    csv.each do |row|
      record = row.to_hash
      record[:serviced] = true
      SvcArea.create!(record)
    end
  end
end