json.array!(@proj_insps) do |proj_insp|
  json.extract! proj_insp, :id, :project_id, :reference, :scheduleDate, :inspectBy, :completeDate, :result
  json.url proj_insp_url(proj_insp, format: :json)
end
