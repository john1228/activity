module Activities
  class HomeController < ApplicationController
    def index
      render json: {shows: ActivityShow.where(activity_id: params[:id]).page(params[:page]||1)}
    end

    def create
      activity_show = ActivityShow.new(comment_params)
      if activity_show.save
        render json: {code: 1}
      else
        render json: {code: 0, message: activity_show.errors.messages.values.join(',')}
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:content, image: [])
    end
  end
end
