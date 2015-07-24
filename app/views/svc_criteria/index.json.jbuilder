json.array!(@svc_criteria) do |svc_criterium|
  json.extract! svc_criterium, :id, :propRes, :propComm, :prevInsp, :hpoz, :cdo, :ownerOcc, :foundation, :yearBuilt, :notes
  json.url svc_criterium_url(svc_criterium, format: :json)
end
