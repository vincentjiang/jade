json.array!(@users) do |user|
  json.extract! user, :id, :email, :hashed_password, :salt, :ename, :cname, :etitle, :ctitle
  json.url user_url(user, format: :json)
end
