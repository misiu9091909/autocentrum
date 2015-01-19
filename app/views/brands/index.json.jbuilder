json.array!(@brands) do |brand|
  json.extract! brand, :id, :name, :link
  json.url brand_url(brand, format: :json)
end
