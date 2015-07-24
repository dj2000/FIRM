json.array!(@svc_areas) do |svc_area|
  json.extract! svc_area, :id, :zip, :city, :state, :serviced
  json.url svc_area_url(svc_area, format: :json)
end
