json.array!(@crews) do |crew|
  json.extract! crew, :id, :foreman, :size, :doubleBook?, :notes
  json.url crew_url(crew, format: :json)
end
