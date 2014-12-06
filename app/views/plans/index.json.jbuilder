json.array!(@plans) do |plan|
  json.extract! plan, :id, :name, :location, :latitude, :longitude, :user_id
  json.url plan_url(plan, format: :json)
end
