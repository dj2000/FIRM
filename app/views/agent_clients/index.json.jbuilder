json.array!(@agent_clients) do |agent_client|
  json.extract! agent_client, :id, :agent_id, :client_id, :agentDate
  json.url agent_client_url(agent_client, format: :json)
end
