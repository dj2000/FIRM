json.array!(@crew_skills) do |crew_skill|
  json.extract! crew_skill, :id, :crew_id, :skill_id
  json.url crew_skill_url(crew_skill, format: :json)
end
