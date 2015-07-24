json.array!(@permits) do |permit|
  json.extract! permit, :id, :reference, :project_id, :issueDate, :issuedBy, :status, :valuation
  json.url permit_url(permit, format: :json)
end
