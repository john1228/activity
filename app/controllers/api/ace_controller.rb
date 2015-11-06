module Api
  class AceController < ApplicationController
    protect_from_forgery

    def apply
      apply = Apply.new(apply_params)
      if apply.save
        AceMailer.send_mail({to: apply.email, name: apply.name, code: '%06d' % apply.id}).deliver_later
        AceMailer.send_mail({to: 'supeng@e-mxing.com', name: apply.name, code: '%06d' % apply.id}).deliver_later
        response.headers['Access-Control-Allow-Origin'] = '*'
        render json: {code: 1}
      else
        render json: {code: 0, message: apply.errors.messages.values.join(';')}
      end
    end

    private
    def apply_params
      params.require(:ace).permit(:name, :mobile, :email).merge(activity_id: 0)
    end
  end
end
