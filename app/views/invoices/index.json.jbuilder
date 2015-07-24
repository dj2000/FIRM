json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :reference, :type, :inspection_id, :project_id, :description, :invoiceDate, :amount
  json.url invoice_url(invoice, format: :json)
end
