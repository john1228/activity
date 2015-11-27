module Api
  module Runnings
    class HomeController < ApplicationController
      protect_from_forgery
      before_filter :auth_user, only: :follow

      def index
        render json: {
                   code: 1,
                   data: Running.where('phase < ?', params[:phase]).page(params[:page]||1).map { |running|
                     running.as_json(only: [:name, :cover, :phase, :follows_count, :url])
                   }
               }
      end

      def follow
        running = Running.find_by(phase: params[:phase])
        follow = Follow.running.new(link_id: running.id, user: @user)
        if follow.save
          render json: {code: 1}
        else
          render json: {code: 0, message: '关注失败'}
        end
      end

      private
      def auth_user
        @user = Rails.cache.fetch(request.headers[:token])
        render json: {code: 0, message: '您还未登录'} if @user.blank?
      end
    end
  end
end
