# Resque tasks
require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'active_scheduler'

namespace :resque do
  task :setup do
    require 'resque'
    Rails.logger.fatal '!!!!!!!!!!!!!!LOADING RESQUE!!!!!!!!!!!!!!!!'

    uri = URI.parse(Rails.application.config.x.redis_url)
    Resque.redis = Redis.new host: uri.host, port: uri.port, password: uri.password


  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'
    yaml_schedule    = YAML.load_file("#{Rails.root}/config/resque_schedule.yml") || {}
    wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap yaml_schedule
    Resque.schedule  = wrapped_schedule
  end

  task :scheduler => :setup_schedule
end
