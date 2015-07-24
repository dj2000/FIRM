json.array!(@pmt_schedules) do |pmt_schedule|
  json.extract! pmt_schedule, :id, :contract_id, :pmtNumber, :pmtDate, :pmtAmount
  json.url pmt_schedule_url(pmt_schedule, format: :json)
end
