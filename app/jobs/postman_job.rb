class PostmanJob < ActiveJob::Base
  queue_as :default

  def perform(email, name, code)
    AceMailer.send_mail({to: email, name: name, code: code}).deliver_now
  end
end
