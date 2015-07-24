json.array!(@properties) do |property|
  json.extract! property, :id, :number, :street, :city, :state, :zip, :crossStreet, :mapPage, :yearBuilt, :size, :stories, :type, :units, :gndUnits, :lotType, :foundation, :hpoz?, :cdo?
  json.url property_url(property, format: :json)
end
