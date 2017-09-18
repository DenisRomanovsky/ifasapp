# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'artelarenda@gmail.com'
  layout 'mailer'
end
