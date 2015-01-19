json.array!(@kinds) do |kind|
  json.extract! kind, :id, :name, :link, :segment
  json.url kind_url(kind, format: :json)
end
