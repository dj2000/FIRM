json.array!(@bids) do |bid|
  json.extract! bid, :id, :inspection_id, :costRepair, :feeSeismicUpg, :feeAdmin, :payPlan_id, :status
  json.url bid_url(bid, format: :json)
end
