json.array!(@agents) do |agent|
  json.extract! agent, :id, :firstName, :lastName, :middleInit, :company, :phoneH, :phoneW, :phoneC, :email, :mailAddress
  json.url agent_url(agent, format: :json)
end
