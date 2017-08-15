if Rails.env == "production"
  uri = URI.parse(Rails.application.config.x.redis_url)
  #puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
  #puts Rails.application.config.x.redis_url
  #puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
  Resque.redis = Redis.new host:uri.host, port:uri.port, password:uri.password
else

end