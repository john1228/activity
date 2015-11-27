class PostmanJob < ActiveJob::Base
  queue_as :default

  def perform(mailer, email, name, code)
    Object.const_get(mailer).send_mail({to: email, name: name, code: code}).deliver_now
    Object.const_get(mailer).send_mail({to: 'supeng@e-mxing.com', name: name, code: code}).deliver_now
  end
end
