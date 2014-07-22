json.array!(@urls) do |url|
  json.extract! url, :id, :url, :unique_key, :hits
  json.url url_url(url, format: :json)
end
