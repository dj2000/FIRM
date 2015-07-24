json.array!(@commissions) do |commission|
  json.extract! commission, :id, :year, :weekNo, :rate
  json.url commission_url(commission, format: :json)
end
