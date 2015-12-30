class NjMailer < ApplicationMailer
  def send_mail(params={})
    @name = params[:name]
    @code = params[:code]
    attachments.inline['1.jpg'] = File.read("#{Rails.root}/app/assets/images/nj/1.jpg")
    attachments.inline['3.jpg'] = File.read("#{Rails.root}/app/assets/images/nj/3.jpg")
    attachments.inline['4.jpg'] = File.read("#{Rails.root}/app/assets/images/nj/4.jpg")
    attachments.inline['5.jpg'] = File.read("#{Rails.root}/app/assets/images/nj/5.jpg")
    attachments.inline['6.jpg'] = File.read("#{Rails.root}/app/assets/images/nj/6.jpg")
    mail(
        :subject => '美型-MR.X工作室特色课程报名提醒',
        :to => params[:to]
    )
  end
end
