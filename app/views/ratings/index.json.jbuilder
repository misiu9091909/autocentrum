json.array!(@ratings) do |rating|
  json.extract! rating, :id, :ratings_count, :again_count, :rates, :again
  json.url rating_url(rating, format: :json)
end
