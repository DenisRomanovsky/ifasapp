# frozen_string_literal: true

# Wrapper class for all jobs.
class ApplicationJob < ActiveJob::Base
  before_perform do |job|
    ActiveRecord::Base.clear_active_connections!
    Rails.logger.fatal("Job starts: #{job}")
  end

  after_perform do |job|
    Rails.logger.fatal("Job ended: #{job}")
  end
end
