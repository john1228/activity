class NoticeMailer < ApplicationMailer
  def send_mail(params={})
    mail(:subject => '邮件测试',
         :to => params[:to],
         :from => 'hr@e-mxing.com',
         :date => params[:content]||'测试文本'
    )
  end
end
