# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'mail@hypocryte.monster'
  layout 'mailer'
end
