module Api
  module Activities
    class HomeController < ApplicationController
      def index
        render json: {activity: Activity.order(id: :desc).page(params[:page]||1).map { |activity|
                 activity.as_json(only: [:id, :title, :start, :end, :address, :fee, :apply_count], methods: :cover_url)
               }}
      end

      def show
        activity = Activity.find(params[:id])
        render json: {activity: activity.as_json(only: [:id, :title, :html_subtitle, :start, :end, :address, :fee, :apply_count, :html_body], methods: [:cover_url, :created])}
      end

      def create
        activity = Activity.new(activity_params)
        if activity.save
          render json: {code: 1}
        else
          render json: {code: 0, message: activity.errors.messages.values.join(',')}
        end
      end

      private
      def activity_params
        params.require(:activity).permit(:title, :cover, :start, :end, :enroll, :address, :gather, :limit, :fee, :stay, :insurance, :tip, :bak,
                                         intro: [:title, :desc, :image])
      end
    end
  end
end
