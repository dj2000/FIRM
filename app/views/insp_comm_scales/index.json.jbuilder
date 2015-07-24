json.array!(@insp_comm_scales) do |insp_comm_scale|
  json.extract! insp_comm_scale, :id, :inspector_id, :scaleStart, :scaleEnd, :rate
  json.url insp_comm_scale_url(insp_comm_scale, format: :json)
end
