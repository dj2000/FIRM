json.array!(@skills) do |skill|
  json.extract! skill, :id, :skill
  json.url skill_url(skill, format: :json)
end
