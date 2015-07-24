json.array!(@inspectors) do |inspector|
  json.extract! inspector, :id, :firstName, :lastName, :middleInit, :senior, :phoneH, :phoneC, :address, :city, :state, :zip, :email
  json.url inspector_url(inspector, format: :json)
end
