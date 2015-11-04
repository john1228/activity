module Api
  class AceController < ActionController::Base
    def apply
      apply = Apply.new(apply_params)
      if apply.save
        render json: {code: 1}
      else
        render json: {code: 0, message: apply.errors.messages.values.join(';')}

      end
    end

    private
    def apply_params
      params.permit(:name, :mobile, :email).merge(activity_id: 0)
    end
  end
end
