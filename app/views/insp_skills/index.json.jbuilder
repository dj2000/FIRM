json.array!(@insp_skills) do |insp_skill|
  json.extract! insp_skill, :id, :inspector_id, :skill_id
  json.url insp_skill_url(insp_skill, format: :json)
end
