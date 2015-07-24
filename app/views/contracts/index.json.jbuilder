json.array!(@contracts) do |contract|
  json.extract! contract, :id, :bid_id, :payPlan_id, :date, :signedBy, :acceptedBy, :dateSigned, :downPmtAmt, :downPmtDate
  json.url contract_url(contract, format: :json)
end
