module Activities
  class HomeController < ActionController::Base
    def index
      render json: {shows: Apply.where(activity_id: params[:id]).page(params[:page]||1)}
    end

    def create
      apply = Apply.new(apply_params)
      if apply_params.save
        render json: {code: 1}
      else
        render json: {code: 0, message: apply_params.errors.messages.values.join(',')}
      end
    end

    private
    def apply_params
      params.require(:apply).permit(:name, :mobile)
    end
  end
end
