json.array!(@roles) do |role|
  json.extract! role, :id, :desc
  json.url role_url(role, format: :json)
end
