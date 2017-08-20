# frozen_string_literal: true

# This redis is needed for the admin pages.
if Rails.application.config.x.redis_url
  $redis = Redis.new(url: Rails.application.config.x.redis_url)
end
