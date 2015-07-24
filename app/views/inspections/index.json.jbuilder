json.array!(@inspections) do |inspection|
  json.extract! inspection, :id, :application_id, :fCondition, :businessCards, :nOD, :nOG, :paid?, :reportURL, :footprintURL, :repairs?, :permit?, :interiorAccess, :verifiedReport, :verifiedComp, :notes
  json.url inspection_url(inspection, format: :json)
end
