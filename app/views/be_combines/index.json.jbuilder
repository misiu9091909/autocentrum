json.array!(@be_combines) do |be_combine|
  json.extract! be_combine, :id, :name, :link, :start_year, :end_year, :techspec
  json.url be_combine_url(be_combine, format: :json)
end
