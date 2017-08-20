require 'resque/server'
require 'resque_scheduler'
require 'resque/scheduler'
require 'active_scheduler'
require 'resque/tasks'

# frozen_string_literal: true

if Rails.env == 'production'
  uri = URI.parse(Rails.application.config.x.redis_url)

  Rails.logger.fatal '!!!!!!!!!!!!!!LOADING RESQUE!!!!!!!!!!!!!!!!'

  Resque.redis = Redis.new host: uri.host, port: uri.port, password: uri.password

  yaml_schedule    = YAML.load_file("#{Rails.root}/config/resque_schedule.yml") || {}
  wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap yaml_schedule
  Resque.schedule  = wrapped_schedule
end
