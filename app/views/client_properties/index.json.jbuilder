json.array!(@client_properties) do |client_property|
  json.extract! client_property, :id, :client_id, :property_id, :clientType, :typeDate, :occupiedBy, :escrow, :escrowDate
  json.url client_property_url(client_property, format: :json)
end
