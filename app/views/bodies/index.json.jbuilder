json.array!(@bodies) do |body|
  json.extract! body, :id, :name, :link, :body_type, :start_year, :end_year, :techspec
  json.url body_url(body, format: :json)
end
