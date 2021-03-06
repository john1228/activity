module Api
  class AceController < ApplicationController
    protect_from_forgery

    def apply
      apply = Apply.ace.new(apply_params)
      if apply.save
        PostmanJob.perform_later(AceMailer.name, apply.email, apply.name, '%05d'%apply.id)
        SmsJob.perform_later(apply.mobile, SMS['通知'], ["#{apply.name}", 'ACE'])
        response.headers['Access-Control-Allow-Origin'] = '*'
        render json: {code: 1}
      else
        response.headers['Access-Control-Allow-Origin'] = '*'
        render json: {code: 0, message: apply.errors.messages.values.join(';')}
      end
    end

    private
    def apply_params
      params.require(:ace).permit(:name, :mobile, :email)
    end
  end
end
