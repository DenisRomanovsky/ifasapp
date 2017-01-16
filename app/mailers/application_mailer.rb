class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@mail.com"
  layout 'mailer'
end
