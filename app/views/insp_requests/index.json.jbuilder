json.array!(@insp_requests) do |insp_request|
  json.extract! insp_request, :id, :callTime, :callerType, :referalSource, :client_id, :agent_id, :property_id, :selectInsp
  json.url insp_request_url(insp_request, format: :json)
end
