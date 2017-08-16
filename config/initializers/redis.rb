# frozen_string_literal: true

if Rails.application.config.x.redis_url
  $redis = Redis.new(url: Rails.application.config.x.redis_url)
end
