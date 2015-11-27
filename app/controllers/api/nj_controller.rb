module Api
  class NjController < ApplicationController
    protect_from_forgery

    def apply
      apply = Apply.new(apply_params)
      if apply.save
        PostmanJob.perform_later(apply.email, apply.name, '%05d'%apply.id)
        SmsJob.perform_later(apply.mobile, SMS['通知'], ["#{apply.name}", '美型-王宁运动学院(南京)'])
        response.headers['Access-Control-Allow-Origin'] = '*'
        render json: {code: 1}
      else
        response.headers['Access-Control-Allow-Origin'] = '*'
        render json: {code: 0, message: apply.errors.messages.values.join(';')}
      end
    end

    private
    def apply_params
      params.require(:nj).permit(:name, :mobile, :email).merge(activity_id: -1)
    end
  end
end
