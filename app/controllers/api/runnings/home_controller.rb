module Api
  module Runnings
    class HomeController < ApplicationController
      protect_from_forgery
      before_filter :auth_user, only: :follow

      def index
        running = Running.find_by(phase: params[:phase])
        if running.present?
          running.update_attribute(:views_count, running.views_count + 1)
          render json: {
                     code: 1,
                     data: {
                         current: running.as_json(only: [:name, :cover, :phase, :follows_count, :url]),
                         history: Running.where('phase < ?', params[:phase]).page(params[:page]||1).map { |history_running|
                           history_running.as_json(only: [:name, :cover, :phase, :follows_count, :url])
                         },
                         comment: Comment.running.where(source_id: running.id).count,
                         likes: running.likes_count,
                         views: running.views_count,
                     }
                 }
        else
          render json: {code: 0, message: '你查看的活动不存组'}
        end
      end

      def follow
        running = Running.find_by(phase: params[:phase])
        follow = Follow.running.new(link_id: running.id, user: @user)
        if follow.save
          render json: {code: 1}
        else
          render json: {code: 0, message: '已经关注'}
        end
      end

      def like
        running = Running.find_by(phase: params[:phase])
        if running.update_attribute(:likes_count, running.likes_count + 1)
          render json: {code: 1}
        else
          render json: {code: 0, message: '已经关注'}
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
