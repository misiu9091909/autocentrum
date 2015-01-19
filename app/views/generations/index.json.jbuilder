json.array!(@generations) do |generation|
  json.extract! generation, :id, :name, :link, :start_year, :end_year
  json.url generation_url(generation, format: :json)
end
