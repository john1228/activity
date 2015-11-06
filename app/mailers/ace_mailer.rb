class AceMailer < ApplicationMailer
  def send_mail(params={})
    @name = params[:name]
    @code = params[:code]
    attachments.inline['1.jpg'] = File.read("#{Rails.root}/app/assets/images/1.jpg")
    attachments.inline['2.jpg'] = File.read("#{Rails.root}/app/assets/images/2.jpg")
    attachments.inline['3.jpg'] = File.read("#{Rails.root}/app/assets/images/3.jpg")
    attachments.inline['4.jpg'] = File.read("#{Rails.root}/app/assets/images/4.jpg")
    attachments.inline['5.jpg'] = File.read("#{Rails.root}/app/assets/images/5.jpg")
    attachments.inline['6.jpg'] = File.read("#{Rails.root}/app/assets/images/6.jpg")
    mail(
        :subject => 'ACE报名提醒',
        :to => 'junwei@e-mxing.com'
    )
  end
end
