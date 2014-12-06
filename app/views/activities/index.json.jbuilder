json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :category, :photo_url, :latitude, :longitude, :plan_id
  json.url activity_url(activity, format: :json)
end
