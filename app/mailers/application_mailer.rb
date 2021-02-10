class ApplicationMailer < ActionMailer::Base
  default :from => ENV['SECRET_ADDRESS']
  layout 'mailer'
end
