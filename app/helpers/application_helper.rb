# frozen_string_literal: true

# Basic Application Helpers.
module ApplicationHelper
  def minsk_time(time)
    time + 3.hours
  end

  def redirect_back(fallback_url)
    request.env['HTTP_REFERER'] || fallback_url
  end
end
