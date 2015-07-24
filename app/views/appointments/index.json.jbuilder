json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :inspRequest_id, :schedStart, :schedEnd, :allDay, :inspector_id, :contact, :inspFee, :prepaid, :pmtMethod, :pmtRef, :notes
  json.url appointment_url(appointment, format: :json)
end
