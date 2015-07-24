json.array!(@pay_plans) do |pay_plan|
  json.extract! pay_plan, :id, :jobMinAmt, :jobMaxAmt, :pmt1Pcnt, :pmt2Pcnt, :pmt3Pcnt, :pmt4Pcnt, :pmt5Pcnt, :pmt1Desc, :pmt2Desc, :pmt3Desc, :pmt4Desc, :pmt5Desc
  json.url pay_plan_url(pay_plan, format: :json)
end
