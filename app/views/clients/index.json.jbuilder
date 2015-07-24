json.array!(@clients) do |client|
  json.extract! client, :id, :firstName, :lastName, :middleInit, :phoneH, :phoneW, :phoneC, :email, :mailAddress
  json.url client_url(client, format: :json)
end
