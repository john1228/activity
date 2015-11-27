module Api
  class NjController < ApplicationController
    protect_from_forgery

    def apply
      apply = Apply.nj.new(nj_params)
      if apply.save
        PostmanJob.perform_later(NjMailer.name, apply.email, apply.name, '%05d'%apply.id)
        SmsJob.perform_later(apply.mobile, SMS['通知'], ["#{apply.name}", '美型-王宁运动学院(南京)'])
        render json: {code: 1}
      else
        render json: {code: 0, message: apply.errors.messages.values.join(';')}
      end
    end

    private
    def nj_params
      params.require(:nj).permit(:name, :mobile, :email)
    end
  end
end
