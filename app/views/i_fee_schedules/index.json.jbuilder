json.array!(@i_fee_schedules) do |i_fee_schedule|
  json.extract! i_fee_schedule, :id, :feeActive, :effectiveFrom, :ownerOccRate, :sfrBaseRate, :sfrIncRate, :mfrBaseRate, :mfrIncRate, :insBaseRate, :insIncRate
  json.url i_fee_schedule_url(i_fee_schedule, format: :json)
end
