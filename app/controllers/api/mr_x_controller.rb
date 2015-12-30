module Api
  class MrController < ApplicationController
    protect_from_forgery

    def apply
      apply = Apply.mr.new(mr_x_params)
      if apply.save
        PostmanJob.perform_later(NjMailer.name, apply.email, apply.name, '%05d'%apply.id)
        PostmanJob.perform_later(NjMailer.name, '1052573903@qq.com', apply.name, '%05d'%apply.id)
        PostmanJob.perform_later(NjMailer.name, '283781320@e-mxing.com', apply.name, '%05d'%apply.id)
        SmsJob.perform_later(apply.mobile, SMS['通知'], ["#{apply.name}", '美型-MR.X健身工作室'])
        render json: {code: 1}
      else
        render json: {code: 0, message: apply.errors.messages.values.join(';')}
      end
    end

    private
    def mr_x_params
      params.require(:nj).permit(:name, :mobile, :email)
    end
  end
end
