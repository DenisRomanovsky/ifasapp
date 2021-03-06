# frozen_string_literal: true

if Rails.env == 'production'
  uri = URI.parse(Rails.application.config.x.redis_url)

  Rails.logger.fatal '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
  Rails.logger.fatal Rails.application.config.x.redis_url
  Rails.logger.fatal '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'

  Resque.redis = Redis.new host: uri.host, port: uri.port, password: uri.password
end
