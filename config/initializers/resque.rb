# This redis is needed for the admin pages.
if Rails.application.config.x.redis_url
  uri = URI.parse(Rails.application.config.x.redis_url)
  $redis = Redis.new host: uri.host, port: uri.port, password: uri.password
end