class PostmanJob < ActiveJob::Base
  queue_as :default

  def perform(email, name, code)
    AceMailer.send_mail({to: email, name: name, code: code}).deliver_now
    #AceMailer.send_mail({to: 'supeng@e-mxing.com', name: apply.name, code: '%06d' % apply.id}).deliver_later
  end
end
