json.array!(@comm_histories) do |comm_history|
  json.extract! comm_history, :id, :inspection_id, :caller, :caller, :recipient, :callSummary, :callOutcome, :callBackDate, :notes
  json.url comm_history_url(comm_history, format: :json)
end
