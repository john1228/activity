module Api
  class AceController < ApplicationController
    protect_from_forgery

    def apply
      apply = Apply.new(apply_params)
      if apply.save
        PostmanJob.perform_later(apply.email, apply.name, '%05d'%apply.id)
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
