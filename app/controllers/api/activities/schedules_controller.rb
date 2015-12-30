module Api
  module Activities
    class SchedulesController < ApplicationController
      def index
        activity = Activity.find(params[:id])
        render json: {
                   activity: activity.schedules.order(date: :desc).map { |schedule|
                     schedule.as_json(only: [:title, :date, :start, :end, :tutor, :address])
                   }
               }
      end
    end
  end
end
