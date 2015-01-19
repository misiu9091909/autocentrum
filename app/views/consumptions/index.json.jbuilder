json.array!(@consumptions) do |consumption|
  json.extract! consumption, :id, :fuel_type, :min, :max, :min_long, :average, :official, :count
  json.url consumption_url(consumption, format: :json)
end
