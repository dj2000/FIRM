json.array!(@receipts) do |receipt|
  json.extract! receipt, :id, :reference, :date, :invoice_id, :amount, :recBy
  json.url receipt_url(receipt, format: :json)
end
