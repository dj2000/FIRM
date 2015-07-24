json.array!(@proj_scheds) do |proj_sched|
  json.extract! proj_sched, :id, :project_id, :crew_id, :date, :startTime, :endTime, :notes
  json.url proj_sched_url(proj_sched, format: :json)
end
