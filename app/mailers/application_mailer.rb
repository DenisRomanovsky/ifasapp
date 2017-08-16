# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@mail.com'
  layout 'mailer'
end
