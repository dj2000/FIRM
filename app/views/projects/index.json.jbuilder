json.array!(@projects) do |project|
  json.extract! project, :id, :vcDate, :contract_id, :jobCost, :scheduleBy, :schedulePref, :estDuration, :scheduleStart, :scheduleEnd, :authorizedBy, :authorizedOn, :crew_id, :verifiedAccess, :verifiedEW, :notes
  json.url project_url(project, format: :json)
end
